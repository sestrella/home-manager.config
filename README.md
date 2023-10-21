# Home Manager Configuration

[![CI](https://github.com/sestrella/nix-home/actions/workflows/ci.yml/badge.svg)](https://github.com/sestrella/nix-home/actions/workflows/ci.yml)

My [Home Manager][home-manager] configuration

## Requirements

- Install [Nix](https://nixos.org/guides/install-nix.html)
- Enable [Flakes](https://nixos.wiki/wiki/Flakes#Permanent) permanently

## Getting Started

Clone the repository:

```
git clone https://github.com/sestrella/nix-darwin-config.git ~/.config/home-manager
```

Activate the configuration:

```
nix run home-manager/master -- init --switch
```

## Inspired By

A list of repositories that inspired this one:

- [HugoReeves/nix-home](https://github.com/HugoReeves/nix-home/)
- [gvolpe/nix-config](https://github.com/gvolpe/nix-config/)
- [ryantm/home-manager-template](https://github.com/ryantm/home-manager-template/)

[home-manager]: https://github.com/nix-community/home-manager
