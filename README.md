# dotfiles

Personal configuration, managed with [GNU Stow](https://www.gnu.org/software/stow/).

The repository is the source of truth: each package mirrors the path the file
should have inside `$HOME`, and `stow` creates the symlinks.

```
zsh/.zshrc                    ->  ~/.zshrc
kitty/.config/kitty/          ->  ~/.config/kitty/
```

## Install

```sh
git clone https://github.com/0x14Rp/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The script detects the operating system and installs the packages that apply to
it. Any file already in place is moved to `~/.dotfiles-backup-<date>/`; nothing
is deleted.

Stow has to be installed first:

```sh
brew install stow          # macOS
sudo pacman -S stow        # Arch
sudo apt install stow      # Debian / Ubuntu
```

### Options

```sh
./install.sh -n              # dry run: show what it would do, change nothing
./install.sh nvim kitty      # install only those packages
./install.sh -d              # uninstall (remove the symlinks)
./install.sh -h              # help
```

Run `./install.sh -n` first to see which files would be moved aside.

## Packages

Cross-platform:

| Package | What it is |
|---|---|
| `zsh` | `.zshrc` and `.zshenv`. Linux-specific bits live in an `if [[ "$OSTYPE" == linux* ]]` block |
| `starship` | prompt |
| `nvim` | Neovim: lazy.nvim, LSP through Mason, rose-pine |
| `kitty` | terminal |
| `wezterm` | terminal |
| `lsd` | `ls` replacement |
| `btop` | system monitor |
| `fastfetch` | system info, with the `ff` launcher |

Linux only (Wayland). `install.sh` skips these on macOS:

| Package | What it is |
|---|---|
| `niri` | compositor (the one I use) |
| `hypr` | Hyprland, hyprlock, hyprpaper |
| `waybar` | status bar |
| `wofi` | launcher |
| `rofi` | rofi theme |
| `mako` | notifications |
| `wlogout` | power menu |
| `darkman` | automatic light/dark switching based on sunrise and sunset |
| `MangoHud` | gaming HUD |

## Day-to-day use

The files under `~/.config` are symlinks into this repo, so editing either side
is the same thing. To publish changes:

```sh
cd ~/dotfiles
git add -A && git commit -m "..." && git push
```

To add a new package, mirror the path and stow it:

```sh
mkdir -p ~/dotfiles/foo/.config/foo
mv ~/.config/foo/config.toml ~/dotfiles/foo/.config/foo/
stow -t ~ foo
```

## Things to keep in mind

- **Never version a file that another program rewrites with `sed -i`.** That
  destroys the symlink and replaces it with a regular file, and the repo
  silently stops reflecting reality. This is why `gtk-3.0/settings.ini` and
  `gtk-4.0/settings.ini` are left out: darkman rewrites them on every theme
  switch.
- **`waybar`** hardcodes `"output": [ "DP-2" ]`. On another machine the monitor
  name has to be changed or the bar will not show up.
- **`niri`** does not expand `~` or `$HOME` in `spawn-at-startup`, since it runs
  commands without a shell. Wrap the command in `sh -c` to use variables.
- **`MangoHud`** carries a `pci_dev` and an `output_folder` tied to this machine.
- Credentials are never versioned: `gh/hosts.yml`, `~/.ssh`, `~/.gnupg` and
  `~/.gitconfig` are deliberately excluded.
