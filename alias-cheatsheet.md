# Alias Cheatsheet
Aliases are nothing more than a keyboard shortcut. If one includes `alias gs='git status'` in the .bashrc (or .zshrc), then each `gs` typed into the command line will execute `git status` in the background.

## List of common aliases
```bash
alias g='git'
alias gs='git status'
alias ts='tig status'
alias gb='git branch'
alias gcb='git checkout -b'
alias gcd='git checkout develop'
alias gcm='git checkout master'
alias gcmsg='git commit -m'
alias gc='git commit'
alias gco='git checkout'
alias ga='git add'
alias gd='git diff'
alias gl='git pull'
alias glgg='git log --graph'
alias gm='git merge'
alias gp='git push'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
```
