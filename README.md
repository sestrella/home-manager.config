# [nix-darwin] configuration

[![CI](https://github.com/sestrella/nix-home/actions/workflows/ci.yml/badge.svg)](https://github.com/sestrella/nix-home/actions/workflows/ci.yml)

My system configuration managed via `nix-darwin`.

## Requirements

- Install [Nix](https://nixos.org/guides/install-nix.html)
- Enable [Flakes](https://nixos.wiki/wiki/Flakes#Permanent) permanently

## Getting Started

Activate the system configuration for the first time:

```sh
nix build .#darwinConfigurations.ci.system
```

Next time, update system configuration running the following command:

```sh
./bin/switch
```

## Inspired By

A list of repositories that inspired this one:

- [HugoReeves/nix-home](https://github.com/HugoReeves/nix-home/)
- [gvolpe/nix-config](https://github.com/gvolpe/nix-config/)
- [ryantm/home-manager-template](https://github.com/ryantm/home-manager-template/)

[nix-darwin]: https://github.com/LnL7/nix-darwin
