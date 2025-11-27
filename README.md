# Home Manager Configuration

[![Build](https://github.com/sestrella/home-manager.config/actions/workflows/build.yml/badge.svg)](https://github.com/sestrella/home-manager.config/actions/workflows/build.yml)

My [Home Manager](https://github.com/nix-community/home-manager) configuration.

## Requirements

Install Nix using the [nix-installer](https://github.com/DeterminateSystems/nix-installer):

```sh
curl -fsSL https://install.determinate.systems/nix | sh -s -- install --prefer-upstream-nix
```

Add your user to the `extra-trusted-users` in your Nix configuration:

```
# /etc/nix/nix.custom.conf
extra-trusted-users = <user>
```

## Getting Started

Clone the repository to your Home Manager configuration directory:

```sh
git clone https://github.com/sestrella/home-manager.config.git ~/.config/home-manager
```

Run [home-manager](https://github.com/nix-community/home-manager) directly from the `master` branch to apply the configuration:

```sh
nix run home-manager/master -- switch
```

After the first run, use the following command to apply additional configuration changes:

```sh
home-manager switch
```

## Credits

This configuration was inspired by the following projects:

- https://github.com/nvim-lua/kickstart.nvim
- https://github.com/HugoReeves/nix-home
- https://github.com/gvolpe/nix-config
- https://github.com/ryantm/home-manager-template

I also got some inspiration from the following awesome lists:

- [nvim](https://github.com/rockerBOO/awesome-neovim)
- [rust-tools](https://github.com/unpluggedcoder/awesome-rust-tools)
- [tmux](https://github.com/rothgar/awesome-tmux)

# License

This project is licensed under the [MIT License](LICENSE).
