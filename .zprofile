# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

alias sublime='open -a /Applications/Sublime\ Text.app'

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# AWS aliases
source ~/.scripts/aws.sh

# Git aliases
source ~/.scripts/git.sh

# Workable aliases
source ~/.scripts/workable.sh

# UI aliases
source ~/.scripts/ui.sh

# Kubernetes aliases
source ~/.scripts/k8s.sh

# QA Tests aliases
source ~/.scripts/qa_tests.sh

# File system navigation aliases
source ~/.scripts/navigation.sh

# Bash aliases
source ~/.scripts/bash_commands.sh

# Pact aliases
source ~/.scripts/pact.sh

# Jenkins
source ~/.scripts/jenkins.sh

#Mountebank
source ~/.scripts/mb.sh

#Mobile
source ~/.scripts/mobile.sh