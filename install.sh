#!/usr/bin/env bash
#
# Instala los dotfiles creando symlinks con GNU Stow.
# Detecta el sistema y stowea solo los paquetes que corresponden.
#
#   ./install.sh              instala los paquetes de este sistema
#   ./install.sh -n           dry run: muestra que haria, sin tocar nada
#   ./install.sh nvim kitty   instala solo los paquetes que le pases
#   ./install.sh -d           desinstala (quita los symlinks)

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

# Paquetes multiplataforma y paquetes que solo tienen sentido en Linux.
COMUNES=(zsh starship nvim lsd btop fastfetch kitty wezterm)
SOLO_LINUX=(hypr niri waybar wofi wlogout mako rofi MangoHud darkman)

DRY_RUN=false
DESINSTALAR=false

while getopts "ndh" opt; do
    case $opt in
        n) DRY_RUN=true ;;
        d) DESINSTALAR=true ;;
        h) sed -n '2,10p' "$0" | sed 's/^# \?//'; exit 0 ;;
        *) exit 1 ;;
    esac
done
shift $((OPTIND - 1))

# --- que paquetes instalar ------------------------------------------------

if [ $# -gt 0 ]; then
    PAQUETES=("$@")
else
    PAQUETES=("${COMUNES[@]}")
    if [[ "$OSTYPE" == linux* ]]; then
        PAQUETES+=("${SOLO_LINUX[@]}")
    fi
fi

# Descarta los que no existen en el repo, avisando.
VALIDOS=()
for p in "${PAQUETES[@]}"; do
    if [ -d "$DOTFILES/$p" ]; then
        VALIDOS+=("$p")
    else
        echo "aviso: el paquete '$p' no existe en el repo, lo salteo" >&2
    fi
done
[ ${#VALIDOS[@]} -eq 0 ] && { echo "error: no hay paquetes para instalar" >&2; exit 1; }

# --- comprobaciones previas -----------------------------------------------

if ! command -v stow >/dev/null; then
    echo "error: falta GNU Stow. Instalalo con:" >&2
    if [[ "$OSTYPE" == darwin* ]]; then
        echo "  brew install stow" >&2
    else
        echo "  sudo pacman -S stow      # Arch" >&2
        echo "  sudo apt install stow    # Debian/Ubuntu" >&2
    fi
    exit 1
fi

echo "Sistema:  $OSTYPE"
echo "Repo:     $DOTFILES"
echo "Paquetes: ${VALIDOS[*]}"
echo

# --- desinstalar ----------------------------------------------------------

if $DESINSTALAR; then
    for p in "${VALIDOS[@]}"; do
        echo "quitando $p"
        if $DRY_RUN; then
            stow -n -v -D -t "$HOME" -d "$DOTFILES" "$p" || true
        else
            stow -D -t "$HOME" -d "$DOTFILES" "$p"
        fi
    done
    echo
    echo "Listo. Los symlinks fueron removidos."
    exit 0
fi

# --- apartar lo que estorbe -----------------------------------------------
#
# Stow se niega a pisar archivos reales. Antes de instalar, movemos a un
# backup cualquier destino que ya exista y no sea un symlink nuestro.

apartar_conflictos() {
    local paquete="$1" origen destino relativo
    while IFS= read -r -d '' origen; do
        relativo="${origen#$DOTFILES/$paquete/}"
        destino="$HOME/$relativo"

        # Ya resuelve dentro del repo: nada que hacer. Ojo que el destino
        # puede no ser un symlink el mismo y aun asi estar cubierto, porque
        # stow enlaza directorios enteros cuando puede (~/.config/nvim ->
        # repo/nvim/.config/nvim hace que init.lua ya apunte al repo).
        if [ -e "$destino" ] && [[ "$(readlink -f "$destino")" == "$DOTFILES"/* ]]; then
            continue
        fi

        if [ -e "$destino" ] || [ -L "$destino" ]; then
            echo "  aparto $destino"
            if ! $DRY_RUN; then
                mkdir -p "$BACKUP/$(dirname "$relativo")"
                mv "$destino" "$BACKUP/$relativo"
            fi
        fi
    done < <(find "$DOTFILES/$paquete" -type f -print0)
}

for p in "${VALIDOS[@]}"; do
    echo "instalando $p"
    apartar_conflictos "$p"
    if $DRY_RUN; then
        # En simulacion los conflictos son esperados (los archivos no se
        # apartaron de verdad), y stow sale con error. No cortamos: el
        # objetivo del dry run es ver TODOS los paquetes.
        stow -n -v -t "$HOME" -d "$DOTFILES" "$p" || true
    else
        stow -t "$HOME" -d "$DOTFILES" "$p"
    fi
done

echo
if $DRY_RUN; then
    echo "Dry run: no se modifico nada."
    echo
    echo "Si arriba aparecio 'WARNING! ... would cause conflicts', es esperado:"
    echo "en la simulacion los archivos no se apartaron de verdad, asi que stow"
    echo "todavia los ve. En la corrida real se apartan antes y no pasa."
else
    [ -d "$BACKUP" ] && echo "Los archivos que habia se guardaron en: $BACKUP"
    echo "Listo. Abri una terminal nueva para ver los cambios."
fi
