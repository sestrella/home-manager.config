# Home Manager Configuration

[![Build](https://github.com/sestrella/home-manager.config/actions/workflows/build.yml/badge.svg)](https://github.com/sestrella/home-manager.config/actions/workflows/build.yml)
[![Templates](https://github.com/sestrella/home-manager.config/actions/workflows/templates.yml/badge.svg)](https://github.com/sestrella/home-manager.config/actions/workflows/templates.yml)

My [Home Manager](https://github.com/nix-community/home-manager) configuration for macOS.

This repository contains declarative configuration for development tools, shell environment, and utilities using Nix and Home Manager.

## Features

The top features by custom configuration and built-in packages:

- **OpenCode**: CLI with extensive permission rules — sensitive files (`.env`, `.aws/`, `.ssh/`, `.gnupg/`, `.kube/`, keys) blocked from reads, destructive commands (`rm -rf`, force pushes, rebases) denied, and guarded access to secrets and external directories
- **Editor**: Helix as the default editor with LSPs (Bash, Docker Compose, Elixir, Nix, Terraform, JSON, YAML), auto-formatting, relative line numbers, and a launchd agent that syncs the Solarized theme to Helix runtime themes
- **Git**: Configured with Delta as the pager, `rerere`, auto-setup of remote branches, and a rich set of Fish abbreviations for common workflows
- **Shell**: Fish as the login shell with Starship prompt, Homebrew/Nix daemon integration, and abbreviations for Terraform, AWS, Git, Zellij, and Home Manager
- **Bluetooth Input Switcher**: A custom-built Swift package run as a launchd agent that automatically switches input devices when Bluetooth keyboards or mice connect

## Prerequisites

- **macOS** (ARM64/M1/M2+ supported)
- Nix package manager

## Installation

Install Nix using the [nix-installer](https://github.com/DeterminateSystems/nix-installer):

```sh
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
```

Add your user to `extra-trusted-users` in your Nix configuration:

```sh
# /etc/nix/nix.custom.conf
extra-trusted-users = <username>
```

## Usage

There are two ways to use this configuration: fork it and make it your own, or extend it from a fresh project via the included template.

### Option 1: Fork and customize

Fork this repository, then clone it into your Home Manager configuration directory:

```sh
git clone https://github.com/<username>/home-manager.config.git ~/.config/home-manager
```

Adjust the configuration to your liking:

- Set your username in `flake.nix` (the `homeConfigurations` section).
- Toggle modules and tweak settings in `home.nix` and the `home/` directory.

### Option 2: Extend via the template

If you already have a Home Manager setup (or prefer to keep this configuration separate), bootstrap a new project that extends this one:

```sh
nix flake init -t github:sestrella/home-manager.config#default
```

Then customize `home.nix` with your own settings. The template wires up this repository as a flake input; to use it from GitHub instead of a local path, uncomment the `home-manager-config` input in `flake.nix`.

### Activating the configuration

With either approach, activate the configuration the first time by running this flake's default app (a wrapper around `home-manager` that only exists for the initial bootstrap):

```sh
nix run .# -- switch
```

Subsequent updates just need:

```sh
home-manager switch
```

## Updating

To update inputs and apply the latest versions:

```sh
nix flake update
home-manager switch
```

## Troubleshooting

If you encounter issues with Nix permissions, ensure your user is in `extra-trusted-users` and restart the Nix daemon:

```sh
sudo launchctl stop org.nixos.nix-daemon
sudo launchctl start org.nixos.nix-daemon
```

## Inspiration

This configuration was inspired by:

- [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- [HugoReeves/nix-home](https://github.com/HugoReeves/nix-home)
- [gvolpe/nix-config](https://github.com/gvolpe/nix-config)
- [ryantm/home-manager-template](https://github.com/ryantm/home-manager-template)
- [rockerBOO/awesome-neovim](https://github.com/rockerBOO/awesome-neovim)
- [unpluggedcoder/awesome-rust-tools](https://github.com/unpluggedcoder/awesome-rust-tools)
- [rothgar/awesome-tmux](https://github.com/rothgar/awesome-tmux)

## License

This project is licensed under the [MIT License](LICENSE).
