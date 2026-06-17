# Home Manager Configuration

[![CI](https://github.com/sestrella/home-manager.config/actions/workflows/ci.yml/badge.svg)](https://github.com/sestrella/home-manager.config/actions/workflows/ci.yml)

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

### 1. Install Nix

Install Nix using the [nix-installer](https://github.com/DeterminateSystems/nix-installer):

```sh
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
```

### 2. Configure Nix

Add your user to `extra-trusted-users` in your Nix configuration:

```sh
# /etc/nix/nix.custom.conf
extra-trusted-users = <username>
```

### 3. Clone Repository

Clone the repository to your Home Manager configuration directory:

```sh
git clone https://github.com/sestrella/home-manager.config.git ~/.config/home-manager
```

### 4. Apply Configuration

Run `home-manager` via `nix run` for the first time:

```sh
nix run home-manager/release-26.05 -- switch
```

After initial setup, apply changes with:

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
