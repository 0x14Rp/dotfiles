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
