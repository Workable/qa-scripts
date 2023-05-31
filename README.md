# qa-scripts

This repo contains QA-specific shared shell scripts and zsh configuraton for local setup.


## Files

**.zprofile** - Includes sources of shell scripts

**.zshrc** - Source of ohmyzsh.sh

**.zshenv** - Contains env vars and credentials that cannot be shared in Github repo

## Scripts

Includes functions or aliases for aws, k8s, mobile, etc.


# Setup
## Zsh files
!!!!! WARNING !!!!!

In order to align Github repo with your local system you should create the related aliases after deleting the existing files. 
So make sure to firstly backup them!

### Create backup from current files:
* mv ~/.zprofile ~/.zprofile-backup
* mv ~/.zshrc ~/.zshrc-backup
* mv ~/.zshenv ~/.zshenv-backup

### Create aliases in HOME directory:
* ln -s path_to_repo/.zprofile .zprofile
* ln -s path_to_repo/.zshrc .zshrc
* ln -s path_to_repo/.zshenv .zshenv


## Script files

You can may align newly added files and create new aliases by using sync.sh script:

* mdkir ~/.scripts
* cd ~/path_to_repo/scripts
* chmod +x sync.sh
* ./sync.sh


## Credentials.sh
Sourced by .zshenv, create file under /scripts of local repo
