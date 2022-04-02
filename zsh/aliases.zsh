# Basic aliases
###############

alias reload='. ~/.zshrc'

alias ..='cd ..'
alias ...='cd ../..'

alias cls='clear' # Good 'ol Clear Screen command

alias src='cd ~/src'

# Software aliases
##################

alias lg='lazygit'

alias jl='jupyter lab'
alias jn='jupyter notebook'

alias tb.ligntning=tensorboard --logdir ./lightning_logs
alias tb.darts=tensorboard --logdir ./.darts/runs

# Project aliases
#################

# Vast Outdoor GmbH
alias vast="cd /Users/frederic.montet/'frederic.montet@vast.ch - Google Drive'/'My Drive'/org/vast-software"
alias vast.src='cd ~/src/org/vast-software'
alias vast.ch='cd ~/src/org/vast-software/vast-ch'

# Thesis
alias thesis='cd ~/src/org/heia-fr/thesis-report && code .'
alias thesis.experiments='cd ~/src/org/heia-fr/thesis-experiments && pipenv shell'
alias thesis.publications='cd ~/src/org/heia-fr/thesis-publications && code .'

# HEIA-FR
alias heia.f4='cd ~/src/org/heia-fr/facility-4.0 && pipenv shell'
alias heia.f4.app='cd ~/src/org/heia-fr/facility-4.0_app && pipenv shell'
alias heia.a4='cd ~/src/org/heia-fr/assainissement-4.0 && pipenv shell'
alias heia.a4.app='cd ~/src/org/heia-fr/assainissement-4.0_app && pipenv shell'
alias heia.ta='cd ~/src/org/heia-fr/timeatlas && pipenv shell'

# BBData
alias bbdata.ssh='ssh bbdata-admin@bbdata.smartlivinglab.ch -p 2201'
alias bbdata.sshuttle='sshuttle --dns -r bbdata-admin@bbdata.smartlivinglab.ch:2201 10.10.0.0/24'

# Personal
alias project.tars='cd ~/src/project/tars && pipenv shell'
alias project.fredmontet='cd ~/src/project/fredmontet.com && code .'

# Project templates
alias new.ds='cookiecutter https://github.com/drivendata/cookiecutter-data-science'