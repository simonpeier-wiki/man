# Git Cheatsheet
Useful git commands, that I use frequently.

## Rename last commit
```bash
git commit --amend
```

## Rename any commit
```bash
git rebase -i HEAD~2
```
This rebases the latest two commits. To rename a commit, replace the "pick" with "reword".