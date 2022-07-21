{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "sestrella";
  home.homeDirectory = "/Users/sestrella";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Custom configuration
  imports = [
    ./home/direnv.nix
    ./home/fzf.nix
    ./home/git.nix
    ./home/neovim.nix
    ./home/nix.nix
    ./home/starship.nix
    ./home/tmux.nix
    ./home/zsh.nix
  ];

  home.sessionVariables = {
    # INFO: Fixes https://github.com/NixOS/nix/issues/2033
    NIX_PATH = "$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels\${NIX_PATH:+:$NIX_PATH}";
  };

  home.packages = [
    pkgs.awscli2
    pkgs.fd
    pkgs.jq
    pkgs.ripgrep
    pkgs.watch
  ];
}
