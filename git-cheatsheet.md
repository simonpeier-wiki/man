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


## View changes of a specific commit
```bash
git diff <commit-sha>^!
```

## Reset author of last commit
```bash
git commit --amend --reset-author
```

## Rename local and remote branch
```bash
git branch -m new-name
git push -u origin :old-name new-name
```

## Rebase a dependent branch after squash-merging its base branch
```bash
git checkout branch-2
git rebase --onto origin/master branch-1
```
in short `git rebase --onto origin/master branch-1 branch-2`

### Problem statement
Before squash merge:

```text
master
  \
   A---B---C  branch-1
            \
             D---E  branch-2
```
After branch-1 was squash-merged into master

```text
master:  S
         ↑
         one squashed commit containing A+B+C

old branch-1: A---B---C
                       \
                        D---E  branch-2
```
