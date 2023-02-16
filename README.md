# nix-darwin configuration

[![CI](https://github.com/sestrella/nix-home/actions/workflows/ci.yml/badge.svg)](https://github.com/sestrella/nix-home/actions/workflows/ci.yml)

My system configuration managed via
[nix-darwin](https://github.com/LnL7/nix-darwin).

## Requirements

Install [Nix](https://nixos.org/guides/install-nix.html) with
[Flakes](https://nixos.wiki/wiki/Flakes) enabled

## Getting Started

Activate the system configuration for the first time:

```sh
./bin/build
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
