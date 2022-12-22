# .dot

This repository groups my different 'dot files' with a structure inspired from Zack Holman (https://github.com/holman/dotfiles). Following is an explanation of how my dotfiles work.

## Concept

Everything's built around **relationships**. If you're adding a new relation to your dotfiles, say "pyhton", you can simply add a `java` directory in the `rel` folder and put files in there. 

Anything with an extension of `.zsh` will get automatically included into your shell. Anything with an extension of `.symlink` will get symlinked without extension into `$HOME` when you run the `setup` script

## Main Structure

- `bin/`: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- `rel/`: All relationships go in there.
- `run/`: All scripts go in there.

### Special files in \<relation>

- `<relation>/*.zsh`: Any `.zsh` file get loaded into your environment.
- `<relation>/path.zsh` is loaded first and is expected to setup `$PATH` or similar.
- `<relation>/completion.zsh` is loaded last and to setup autocomplete.
- `<relation>/install.sh` is executed when you run `run/install`. To avoid being loaded automatically, its extension is `.sh`, not `.zsh`.
- `<relation>/*.symlink`: Any file ending in `*.symlink` gets symlinked into
  your `$HOME`.

### Scripts

- `setup` : symlink everything
- `install` : installs everything

## Get Started

```sh
# Install homebrew
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install the dotfiles
git clone https://github.com/fredmontet/dot.git ~/.dot
cd ~/.dot
make setup
```

This will symlink the appropriate files in `.dot` to your home directory.
The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

### Usefull Commands

- `dot` is a simple script that installs some dependencies, sets sane macOS
defaults, and so on. Tweak this script, and occasionally run `dot` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/`.
- `reload` does what it says. It reloads your dotfiles.
