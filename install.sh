#!/usr/bin/env bash
#
# Installs the dotfiles by creating symlinks with GNU Stow.
# Detects the operating system and stows only the packages that apply.
#
#   ./install.sh              install the packages for this system
#   ./install.sh -n           dry run: show what it would do, change nothing
#   ./install.sh nvim kitty   install only the given packages
#   ./install.sh -d           uninstall (remove the symlinks)

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

# Cross-platform packages, and packages that only make sense on Linux.
COMMON=(zsh starship nvim lsd btop fastfetch kitty wezterm)
LINUX_ONLY=(hypr niri waybar wofi wlogout mako rofi MangoHud darkman)

DRY_RUN=false
UNINSTALL=false

while getopts "ndh" opt; do
    case $opt in
        n) DRY_RUN=true ;;
        d) UNINSTALL=true ;;
        h) sed -n '2,10p' "$0" | sed 's/^# \?//'; exit 0 ;;
        *) exit 1 ;;
    esac
done
shift $((OPTIND - 1))

# --- which packages to install --------------------------------------------

if [ $# -gt 0 ]; then
    PACKAGES=("$@")
else
    PACKAGES=("${COMMON[@]}")
    if [[ "$OSTYPE" == linux* ]]; then
        PACKAGES+=("${LINUX_ONLY[@]}")
    fi
fi

# Drop the ones missing from the repo, with a warning.
VALID=()
for p in "${PACKAGES[@]}"; do
    if [ -d "$DOTFILES/$p" ]; then
        VALID+=("$p")
    else
        echo "warning: package '$p' is not in the repo, skipping" >&2
    fi
done
[ ${#VALID[@]} -eq 0 ] && { echo "error: no packages to install" >&2; exit 1; }

# --- preflight checks -----------------------------------------------------

if ! command -v stow >/dev/null; then
    echo "error: GNU Stow is missing. Install it with:" >&2
    if [[ "$OSTYPE" == darwin* ]]; then
        echo "  brew install stow" >&2
    else
        echo "  sudo pacman -S stow      # Arch" >&2
        echo "  sudo apt install stow    # Debian/Ubuntu" >&2
    fi
    exit 1
fi

echo "System:   $OSTYPE"
echo "Repo:     $DOTFILES"
echo "Packages: ${VALID[*]}"
echo

# --- uninstall ------------------------------------------------------------

if $UNINSTALL; then
    for p in "${VALID[@]}"; do
        echo "removing $p"
        if $DRY_RUN; then
            stow -n -v -D -t "$HOME" -d "$DOTFILES" "$p" || true
        else
            stow -D -t "$HOME" -d "$DOTFILES" "$p"
        fi
    done
    echo
    echo "Done. The symlinks were removed."
    exit 0
fi

# --- move conflicting files aside -----------------------------------------
#
# Stow refuses to overwrite real files. Before installing, move to a backup
# any destination that already exists and is not one of our own symlinks.

move_conflicts_aside() {
    local package="$1" source target relative
    while IFS= read -r -d '' source; do
        relative="${source#$DOTFILES/$package/}"
        target="$HOME/$relative"

        # Already resolves inside the repo: nothing to do. Note the target
        # may not be a symlink itself and still be covered, because stow
        # links whole directories when it can (~/.config/nvim ->
        # repo/nvim/.config/nvim makes init.lua point into the repo too).
        if [ -e "$target" ] && [[ "$(readlink -f "$target")" == "$DOTFILES"/* ]]; then
            continue
        fi

        if [ -e "$target" ] || [ -L "$target" ]; then
            echo "  moving aside $target"
            if ! $DRY_RUN; then
                mkdir -p "$BACKUP/$(dirname "$relative")"
                mv "$target" "$BACKUP/$relative"
            fi
        fi
    done < <(find "$DOTFILES/$package" -type f -print0)
}

for p in "${VALID[@]}"; do
    echo "installing $p"
    move_conflicts_aside "$p"
    if $DRY_RUN; then
        # Conflicts are expected in a simulation (the files were not really
        # moved aside, so stow still sees them) and stow exits non-zero.
        # Don't stop: the whole point of a dry run is to show every package.
        stow -n -v -t "$HOME" -d "$DOTFILES" "$p" || true
    else
        stow -t "$HOME" -d "$DOTFILES" "$p"
    fi
done

echo
if $DRY_RUN; then
    echo "Dry run: nothing was changed."
    echo
    echo "If you saw 'WARNING! ... would cause conflicts' above, that is"
    echo "expected: in a simulation the files were not really moved aside, so"
    echo "stow still sees them. On a real run they are moved first."
else
    [ -d "$BACKUP" ] && echo "Existing files were saved to: $BACKUP"
    echo "Done. Open a new terminal to pick up the changes."
fi
