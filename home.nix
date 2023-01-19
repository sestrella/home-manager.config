{ config, pkgs, ... }:

{
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Custom configuration
  imports = [
    ./home/bat.nix
    ./home/fish.nix
    ./home/git.nix
    ./home/neovim.nix
    # ./home/nix.nix
    ./home/ripgrep.nix
    ./home/tmux.nix
  ];

  home.sessionVariables = {
    # https://nix-community.github.io/home-manager/index.html#sec-install-standalone
    NIX_PATH = "$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels\${NIX_PATH:+:$NIX_PATH}";
  };

  home.packages = [
    pkgs.aws-vault
    pkgs.awscli2
    pkgs.awsebcli
    pkgs.jq
    pkgs.luaPackages.luacheck
    pkgs.powershell # TODO: remove this package
    pkgs.stack
    pkgs.terraform
    pkgs.terraform-docs
    pkgs.tfsec
    pkgs.tmate
    pkgs.tree
    pkgs.wget
  ];

  programs.autojump.enable = true;

  programs.direnv.enable = true;

  programs.fzf.enable = true;

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "git";
    };
  };

  programs.starship.enable = true;
}
