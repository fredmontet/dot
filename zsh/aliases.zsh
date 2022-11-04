# Basic aliases
###############

alias reload='. ~/.zshrc'

alias ..='cd ..'
alias ...='cd ../..'
alias cls='clear' # Good 'ol Clear Screen command

alias src='cd ~/src'

# Software aliases
##################

# Editors
alias jl='jupyter lab'
alias jn='jupyter notebook'
alias ide='idea'
alias ds='dataspell'
alias e='code'

# Dev tools
alias k='kubectl'
alias lg='lazygit'
alias tb.ligntning=tensorboard --logdir ./lightning_logs
alias tb.darts=tensorboard --logdir ./.darts/runs

# Project aliases
#################

# Vast Outdoor GmbH
alias vast.ch='cd ~/src/vast-ch'

# Thesis
alias thesis.phd='cd ~/src/thesis-phd && code .'
alias thesis.master='cd ~/src/thesis-master && code .'
alias thesis.experiments='cd ~/src/thesis-experiments && pipenv shell'
alias thesis.publications='cd ~/src/thesis-publications && code .'

# HEIA-FR
alias heia.f4='cd ~/src/facility-4.0 && pipenv shell'
alias heia.f4.app='cd ~/src/facility-4.0_app && pipenv shell'
alias heia.a4='cd ~/src/assainissement-4.0 && pipenv shell'
alias heia.a4.app='cd ~/src/assainissement-4.0_app && pipenv shell'
alias heia.ta='cd ~/src/timeatlas && pipenv shell'

# BBData
alias bbdata.ssh='ssh bbdata-admin@bbdata.smartlivinglab.ch -p 2201'
alias bbdata.sshuttle='sshuttle --dns -r bbdata-admin@bbdata.smartlivinglab.ch:2201 10.10.0.0/24'

# Personal
alias p.jam='cd ~/src/jam && poetry shell'
alias p.tars='cd ~/src/tars && pipenv shell'
alias p.blog='cd ~/src/blog'
alias p.experiments='cd ~/src/experiments && make activate'
alias p.note='cd ~/src/note && pipenv shell'

# Project templates
alias new.ds='cookiecutter https://github.com/fredmontet/template-data-science'
