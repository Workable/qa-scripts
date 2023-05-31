GIT_COMPLETION_CHECKOUT_NO_GUESS=1
GIT_COMPLETION_SHOW_ALL=1

alias gp='git pull'
alias gb='git branch'
alias go='git checkout'
alias gs='git status'
alias gf='git fetch'
alias gclear='git fetch && git branch -v | grep gone | awk '\''{print $1}'\'' | xargs git branch -D'
alias gfind='git grep '
alias glm='git log -n 1 --pretty=format:%H -- '
alias sync='git fetch && git reset --hard origin/`git branch | grep "* " | sed "s/* //g"`'
alias stashnsync='git stash && sync && git stash pop'
alias gshort='git show -s --format=%h'

gfixup(){
 commit=`glm $1`
 git add $1 && git commit --fixup ${commit}
}