# Shortcuts
alias pubkey="{ cat ~/.ssh/id_ed25519.pub 2>/dev/null || cat ~/.ssh/id_rsa.pub 2>/dev/null; } | pbcopy && echo '=> Public key copied to pasteboard.'"
alias email="git config user.email | pbcopy | echo '=> Mail copied to pasteboard.'"
alias reload='. ~/.zshrc'
alias cls='clear'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias src='cd ~/src'
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi

# Editors
# e is a path variable to subl
alias ide='idea'
alias jl='jupyter lab'
alias jn='jupyter notebook'

# Dev tools
alias k='kubectl'
alias lg='lazygit'
alias tb.lightning='tensorboard --logdir ./lightning_logs'
alias tb.darts='tensorboard --logdir ./.darts/runs'

# BBData
alias bbdata.ssh='ssh bbdata-admin@bbdata.smartlivinglab.ch -p 2201'
alias bbdata.sshuttle='sshuttle --dns -r bbdata-admin@bbdata.smartlivinglab.ch:2201 10.10.0.0/24'

# Project templates
alias new.ds='cookiecutter https://github.com/fredmontet/template-data-science'
