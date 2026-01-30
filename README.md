# Travail

Workspace approach to handle multiple projects with multiple features
in parallel in isolated ways, suitable for agents.

You need 5 minutes of reading to know if this works for you, as well as:

- zsh with autoenv plugin (optional)
- tmux (optional)
- opencode (optional)

# Flow

Full console. Opinionated. No magic. No fancy abstractions. You review.

```
projects
    project-xxx
       base        # base repository
       feature-x   # worktree (relative)
       feature-y   # worktree (relative)
    project-yyy
       base        # base repository
       feature-y   # worktree (relative)
```

Each feature is addressed in a tmux window split in two panes, one for
the agent running under a container mounting the feature, the other
for you to commit on the side.

# Facilities

- If your project has a .tool-versions at its root, entering the container will install them,
- A cache folder is created on the host and shared on devel containers to go spawn quickly,
- Your gitconfig is mounted in the devel container if you want to vibe.

# Cookbook

## Initialize the docker image

```zsh
./cli.py build
```

## Create a new project

```zsh
mkdir -p project/<project-name>
cd project/<project-name>
git clone <repo-url> base
```

## Work on a feature

```zsh
cd project/base
git worktree add --relative-path -b <feat/name> ../<name>
cd ../<name>
../../cli.py enter
```

(Note: You can alias `travail` to `path/to/cli.py` for convenience)
