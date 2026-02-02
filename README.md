# Travail

<p align="center">
  <img src="assets/peon.png" alt="Work work" width="200">
</p>

<p align="center">
  <em>"Work work"</em>
</p>

Workspace isolation for parallel feature development.

```
projects/
    webapp/
       base        # initial clone of the repository
       dark-mode   # copy of base on a dedicated feature branch
       api-v2      # another feature, in parallel
```

Each feature lives in its own directory, its own container, its own tmux pane. No conflicts. No context bleeding. Just work.

## Requirements

- Docker
- [uv](https://docs.astral.sh/uv/) (Python package manager)
- opencode *(optional)*

## Installation

```zsh
git clone git@github.com:your-org/travail.git ~/travail
export PATH="$HOME/travail/bin:$PATH"

# Add to your shell profile (.zshrc / .bashrc):
echo 'export PATH="$HOME/travail/bin:$PATH"' >> ~/.zshrc
```

## Quick Start

```zsh
travail setup                              # Build the dev container
travail project add git@github.com:x/y.git # Clone a project
travail feature add webapp dark-mode       # Branch off and isolate
travail shell webapp dark-mode             # Drop into the container
```

## Usage

```
travail - Workspace isolation for parallel feature development

Usage:
  travail <command> [options]

Commands:
  setup              Build the development container image
  shell              Start a shell session in a feature container
  project            Manage projects (add, list)
  feature            Manage features (add, list, remove)

Run 'travail <command> --help' for more information on a command.
```

## Mounting Directories

You can mount additional directories into the container using the `--mount` (or `-m`) flag:

```zsh
# Mount a directory to /mounts/foo
travail shell webapp dark-mode --mount /path/to/foo

# Mount a directory to a specific path
travail shell webapp dark-mode --mount /path/to/foo:/data/foo
```

## How It Works

1. **Projects** are git repos cloned into `projects/<name>/base`
2. **Features** are full copies of base with their own `feat/<name>` branch
3. **Containers** mount your feature directory with shared caches for speed
4. Your `.tool-versions` and `.gitconfig` are respected inside containers
