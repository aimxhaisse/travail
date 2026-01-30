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
       feature-x   # copy of base
       feature-y   # copy of base
    project-yyy
       base        # base repository
       feature-y   # copy of base
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
travail setup
```

## Add a project

```zsh
travail project add <repo-url>
# Example: travail project add git@github.com:acme/webapp.git
```

## List projects

```zsh
travail project list
```

## Create a feature

```zsh
travail feature new <project> <name>
# Example: travail feature new webapp dark-mode
```

This will:
1. Pull latest changes in base
2. Copy base to the new feature directory
3. Create a `feat/<name>` branch

## List features

```zsh
travail feature list              # All features across all projects
travail feature list <project>    # Features for a specific project
```

## Enter a feature container

```zsh
cd projects/<project>/<feature>
travail feature enter

# Or explicitly:
travail feature enter <project> <feature>
```

## Remove a feature

```zsh
travail feature remove <project> <name>
```
