# Home Manager Configuration

[![build](https://github.com/sestrella/home-manager.config/actions/workflows/build.yml/badge.svg)](https://github.com/sestrella/home-manager.config/actions/workflows/build.yml)

My [Home Manager](https://github.com/nix-community/home-manager) configuration.

## Requirements

Install Nix via
[nix-installer](https://github.com/DeterminateSystems/nix-installer).
Alternatively, use the official Nix
[installer](https://nixos.org/guides/install-nix.html) and enable
[Flakes](https://nixos.wiki/wiki/Flakes).

Optionally, mark your user as a trusted user in the global Nix configuration
file

```
# /etc/nix/nix.conf
extra-trusted-users = <user>
```

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

## Credits

A list of projects that inspired me to write this one:

- https://github.com/HugoReeves/nix-home
- https://github.com/gvolpe/nix-config
- https://github.com/ryantm/home-manager-template

I also took some ideas from the following Awesome lists:

- [nvim](https://github.com/rockerBOO/awesome-neovim)
- [rust-tools](https://github.com/unpluggedcoder/awesome-rust-tools)
- [tmux](https://github.com/rothgar/awesome-tmux)
