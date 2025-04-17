# .jam

This repository groups my different 'dot files' with a structure inspired from Zack Holman (https://github.com/holman/dotfiles). Following is an explanation of how my dotfiles work.

This project now uses a Python-based CLI (`jam`) to handle setup and installations.

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

- `jam setup` (or `make setup`): symlink and configure everything
- `jam install` (or `make install`): run all installers

## Get Started

```sh
# Install homebrew
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install the dotfiles
git clone https://github.com/fredmontet/jam.git ~/.jam
cd ~/.jam
make setup
```

This will symlink the appropriate files in `.jam` to your home directory.
The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

### Usefull Commands

- `jam` is a simple script that installs some dependencies, sets sane macOS
defaults, and so on. Tweak this script, and occasionally run `jam` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/`.
- `reload` does what it says. It reloads your dotfiles.
 
## Development

This project uses [Poetry](https://python-poetry.org/) to manage dependencies and create an isolated virtual environment.

If you don't have Poetry installed, follow the instructions at https://python-poetry.org/docs/#installation.

Install the project dependencies and create the virtual environment:
```bash
poetry install
```

Activate the virtual environment:
```bash
poetry shell
```

You can now run the CLI commands directly:
```bash
jam setup
jam install
```

Or prefix commands with `poetry run` without activating the shell:
```bash
poetry run jam setup
poetry run jam install
```
