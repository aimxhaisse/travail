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
       base        # source of truth
       dark-mode   # isolated feature branch
       api-v2      # another feature, in parallel
```

Each feature lives in its own directory, its own container, its own tmux pane. No conflicts. No context bleeding. Just work.

## Requirements

- Docker
- zsh + autoenv plugin *(optional)*
- tmux *(optional)*
- opencode *(optional)*

## Quick Start

```zsh
travail setup                              # Build the dev container
travail project add git@github.com:x/y.git # Clone a project
travail feature new webapp dark-mode       # Branch off and isolate
travail feature enter webapp dark-mode     # Drop into the container
```

## Usage

```
travail - Workspace isolation for parallel feature development

Usage:
  travail <command> [options]

Commands:
  setup              Build the development container image
  project            Manage projects (add, list)
  feature            Manage features (new, list, enter, remove)

Run 'travail <command> --help' for more information on a command.
```

## How It Works

1. **Projects** are git repos cloned into `projects/<name>/base`
2. **Features** are full copies of base with their own `feat/<name>` branch
3. **Containers** mount your feature directory with shared caches for speed
4. Your `.tool-versions` and `.gitconfig` are respected inside containers
