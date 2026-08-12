# Home Manager Configuration

[![Devenv](https://github.com/sestrella/home-manager.config/actions/workflows/devenv.yml/badge.svg)](https://github.com/sestrella/home-manager.config/actions/workflows/devenv.yml)
[![Home Manager](https://github.com/sestrella/home-manager.config/actions/workflows/home-manager.yml/badge.svg)](https://github.com/sestrella/home-manager.config/actions/workflows/home-manager.yml)
[![Templates](https://github.com/sestrella/home-manager.config/actions/workflows/templates.yml/badge.svg)](https://github.com/sestrella/home-manager.config/actions/workflows/templates.yml)

My [Home Manager](https://github.com/nix-community/home-manager) configuration for macOS.

This repository contains declarative configuration for development tools, shell environment, and utilities using Nix and Home Manager.

## Features

- **Bluetooth Input Switcher**: Automatic switching of input devices when Bluetooth keyboards or mice connect; configurable rules in home/bluetooth-input-switcher.
- **Shell**: Fish shell with Starship prompt
- **Editor**: Helix with terminal integration
- **Tools**: Git, AWS CLI, SSH, Zellij, Ghostty terminal emulator
- **DevEnv**: Direnv for environment management
- **GitHub**: GitHub CLI integration

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

With either approach, activate the configuration by running `home-manager` via `nix run` the first time:

```sh
nix run home-manager/master -- switch
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
