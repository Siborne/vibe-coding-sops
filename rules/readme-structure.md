# README Structure Rule

**Rule:** READMEs MUST follow funnel order: what it does → why care → how to use → how to install. Show usage before installation steps.

## The Funnel

Answer four questions in order, top to bottom:

1. **What does it do?** — One sentence + optional visual (screenshot, GIF, diagram)
2. **Why should I care?** — Core value proposition, what pain it solves
3. **How do I use it?** — Show usage first; let people see what they'll get
4. **How do I install it?** — Installation LAST, after the reader has decided to commit

> People want to see what they'll get before investing in setup steps.

## Good Example

```markdown
# lazydocker

Terminal UI for Docker, built with Go and gocui.

<p align="center">
  <img src="demo.gif" width="600">
</p>

## Why lazydocker

Managing Docker from the terminal usually means `docker` + `docker-compose`
plus manually typing container names. lazydocker gives you a single TUI panel
with keyboard shortcuts for all containers, logs, images, and compose services.

## Quick Start

- Press `e` to enter a container shell
- Press `l` to view container logs (live scrolling)
- Press `r` to restart a container
- ... full keybindings below

## Installation

### macOS
brew install jesseduffield/lazydocker/lazydocker

### Linux
Download the [latest release] binary into $PATH.
```

## Anti-Pattern

```markdown
# MyProject

## Installation
Install these dependencies first... [20 lines of setup]

## Configuration
Set these environment variables... [more config]

## API
[large API reference block]

## Contributing
[contributing guide]
```

Problem: the reader gets 50 lines in and still doesn't know what this is or whether they need it.
