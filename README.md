# Home Manager Configuration

[![CI](https://github.com/sestrella/home-manager.config/actions/workflows/ci.yml/badge.svg)](https://github.com/sestrella/home-manager.config/actions/workflows/ci.yml)

My [Home Manager](https://github.com/nix-community/home-manager) configuration.

## Requirements

Install Nix via
[nix-installer](https://github.com/DeterminateSystems/nix-installer).
Alternatively, use the official Nix
[installer](https://nixos.org/guides/install-nix.html) and enable
[Flakes](https://nixos.wiki/wiki/Flakes).

## Getting Started

Clone the repository:

```
git clone https://github.com/sestrella/nix-darwin-config.git ~/.config/home-manager
```

Active the configuration for the first time:

```
nix run home-manager/release-23.11 -- switch
```

**Note:** For future activations, run the `home-manager switch` command.

## Inspired By

A list of projects that inspired me to write this one:

- https://github.com/HugoReeves/nix-home
- https://github.com/gvolpe/nix-config
- https://github.com/ryantm/home-manager-template
