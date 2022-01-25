# Nix Home

[![CI](https://github.com/sestrella/nix-home/actions/workflows/main.yml/badge.svg)](https://github.com/sestrella/nix-home/actions/workflows/main.yml)

My user configuration managed via
[home-manager](https://github.com/nix-community/home-manager).

## Requirements

- Install [nix](https://nixos.org/guides/install-nix.html)

## Getting Started

Clone the repository:

```sh
git clone https://github.com/sestrella/nix-home.git ~/.config/nixpkgs
```

Turn on flakes support:

```sh
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

Build and activate configuration:

```sh
nix develop -c home-manager switch
```

## Inspired By

A list of some repos that inspired me to build this one:

- [HugoReeves/nix-home](https://github.com/HugoReeves/nix-home/)
- [gvolpe/nix-config](https://github.com/gvolpe/nix-config/)
- [ryantm/home-manager-template](https://github.com/ryantm/home-manager-template/)

## References

Some interesting articles that I found handy while building this project:

- [Gnome 3 on NixOS](https://gvolpe.com/blog/gnome3-on-nixos/)
- [Your home in Nix (dotfile management)](https://hugoreeves.com/posts/2019/nix-home/)
