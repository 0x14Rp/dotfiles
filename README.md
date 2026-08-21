# dotfiles

Configuración personal, gestionada con [GNU Stow](https://www.gnu.org/software/stow/).

El repositorio es la fuente de verdad: cada paquete replica la ruta que el
archivo debe tener dentro de `$HOME`, y `stow` crea los symlinks.

```
zsh/.zshrc                    ->  ~/.zshrc
kitty/.config/kitty/          ->  ~/.config/kitty/
```

## Instalación

```sh
git clone https://github.com/0x14Rp/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

El script detecta el sistema e instala los paquetes que corresponden. Los
archivos que ya existan se mueven a `~/.dotfiles-backup-<fecha>/`; no se borra
nada.

Antes hay que tener stow:

```sh
brew install stow          # macOS
sudo pacman -S stow        # Arch
sudo apt install stow      # Debian / Ubuntu
```

### Opciones

```sh
./install.sh -n              # dry run: muestra que haria, sin tocar nada
./install.sh nvim kitty      # instala solo esos paquetes
./install.sh -d              # desinstala (quita los symlinks)
./install.sh -h              # ayuda
```

Conviene correr `./install.sh -n` la primera vez para ver qué se va a apartar.

## Paquetes

Multiplataforma:

| Paquete | Qué es |
|---|---|
| `zsh` | `.zshrc` y `.zshenv`. Lo específico de Linux vive en un bloque `if [[ "$OSTYPE" == linux* ]]` |
| `starship` | prompt |
| `nvim` | Neovim: lazy.nvim, LSP vía Mason, rose-pine |
| `kitty` | terminal |
| `wezterm` | terminal |
| `lsd` | reemplazo de `ls` |
| `btop` | monitor de sistema |
| `fastfetch` | info del sistema, con el lanzador `ff` |

Solo Linux (Wayland). `install.sh` los saltea en macOS:

| Paquete | Qué es |
|---|---|
| `niri` | compositor (el que uso) |
| `hypr` | Hyprland, hyprlock, hyprpaper |
| `waybar` | barra |
| `wofi` | lanzador |
| `rofi` | tema de rofi |
| `mako` | notificaciones |
| `wlogout` | menú de apagado |
| `darkman` | cambio automático claro/oscuro según el sol |
| `MangoHud` | HUD de gaming |

## Uso diario

Los archivos en `~/.config` son symlinks al repo, así que editar cualquiera de
los dos lados es lo mismo. Para publicar cambios:

```sh
cd ~/dotfiles
git add -A && git commit -m "..." && git push
```

Para sumar un paquete nuevo, replicar la ruta y stowear:

```sh
mkdir -p ~/dotfiles/foo/.config/foo
mv ~/.config/foo/config.toml ~/dotfiles/foo/.config/foo/
stow -t ~ foo
```

## Detalles a tener en cuenta

- **No versionar archivos que otro programa reescriba con `sed -i`.** Eso
  destruye el symlink y lo reemplaza por un archivo normal, y el repo deja de
  reflejar la realidad sin avisar. Por eso `gtk-3.0/settings.ini` y
  `gtk-4.0/settings.ini` quedaron afuera: darkman los reescribe en cada cambio
  de tema.
- **`waybar`** fija `"output": [ "DP-2" ]`. En otra máquina hay que cambiar el
  nombre del monitor o la barra no aparece.
- **`niri`** no expande `~` ni `$HOME` en `spawn-at-startup`: no usa shell. Para
  usar variables hay que envolver el comando en `sh -c`.
- **`MangoHud`** trae `pci_dev` y `output_folder` atados a esta máquina.
- Nunca se versionan credenciales: `gh/hosts.yml`, `~/.ssh`, `~/.gnupg` ni
  `~/.gitconfig` están fuera a propósito.
