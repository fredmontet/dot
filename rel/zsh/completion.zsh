# Loaded LAST by zshrc.symlink (after `compinit`) — the right place for plugins
# and tools that register completions or ZLE widgets. Everything here is guarded
# so a not-yet-installed tool never breaks the shell.

brew_prefix=${BREW_PREFIX:-/opt/homebrew}

# fzf — fuzzy history (Ctrl-R), file search (Ctrl-T), and completion
if command -v fzf >/dev/null; then
  eval "$(fzf --zsh 2>/dev/null)"
fi

# zoxide — smarter `cd` via the `z` command
if command -v zoxide >/dev/null; then
  eval "$(zoxide init zsh)"
fi

# Fish-like autosuggestions
if [[ -f "$brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
  source "$brew_prefix/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Syntax highlighting — must be sourced last to wrap the line editor
if [[ -f "$brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$brew_prefix/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

unset brew_prefix
