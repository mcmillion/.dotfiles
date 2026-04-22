# Rebase current branch on top of latest master/main

Rebase current branch onto latest master/main:
1. Detect if repo uses 'master' or 'main' as default branch
2. Fetch latest from origin
3. Rebase onto origin/master or origin/main
4. Use the history of the local branch to figure out the best way to fix any merge conflicts. If you cannot confidently resolve a conflict, ask the user for guidance before proceeding.
5. After the rebase completes successfully, force push with lease: `git push --force-with-lease`
