# Nix Home

[![CI](https://github.com/sestrella/nix-home/actions/workflows/ci.yml/badge.svg)](https://github.com/sestrella/nix-home/actions/workflows/ci.yml)

My user configuration managed via
[home-manager](https://github.com/nix-community/home-manager).

## Requirements

- Install [Nix](https://nixos.org/guides/install-nix.html)
- Enable [Nix Flakes](https://nixos.wiki/wiki/Flakes)

## Getting Started

Activate the configuration for the first time:

```sh
nix build --no-link .#homeConfigurations.sestrella.activationPackage
"$(nix path-info .#homeConfigurations.sestrella.activationPackage)"/activate
```

Next time, update the configuration via `home-manager`:

```sh
home-manager switch --flake .#sestrella
```

## Update nodePackages

Run the following commands:

```sh
cd node-packages
node2nix -i node-packages.json
```

## Inspired By

A list of some repos that inspired me to build this one:

- [HugoReeves/nix-home](https://github.com/HugoReeves/nix-home/)
- [gvolpe/nix-config](https://github.com/gvolpe/nix-config/)
- [ryantm/home-manager-template](https://github.com/ryantm/home-manager-template/)
