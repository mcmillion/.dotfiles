# Rebase current branch on top of latest master/main

- NEVER use `git -C` - always run git commands directly in the current directory
- Use the git-expert agent

Rebase current branch onto latest master/main:
1. Detect if repo uses 'master' or 'main' as default branch
2. Fetch latest from origin
3. Rebase onto origin/master or origin/main
4. Use the history of the local branch to figure out the best way to fix any merge conflicts
