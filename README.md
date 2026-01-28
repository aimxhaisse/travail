# Travail

Workspace approach to handle multiple projects with multiple features
in parallel in isolated ways, suitable for agents. There is nothing
new here, it's just a CLI-oriented flow I currently use.

Read `.devrc` and then you are ready to work.

```zsh
source .devrc
travail-setup
```

# Current flow

This is opinionated.

- open a tmux window
- create a feature worktree
- split tmux window in two panes
- enter the feature container and do your stuff in one pane
- commit from the outside on the other container
- push and eventually destroy worktree

# Create a new project

```zsh
mkdir -p project/<project-name>
cd project/<project-name>
git clone <repo-url> base
```

# Work on a feature

```zsh
cd project/base
git worktree add --relative-path -b <feat/name> ../<name>
cd ../<name>
travail-enter
```
