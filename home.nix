{ config, pkgs, lib, ... }:

{
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # Custom configuration
  imports = [
    ./home/alacritty
    ./home/bat
    ./home/git
    ./home/home-manager
    ./home/neovim
    ./home/nix
    ./home/ripgrep
    ./home/tmux
  ];

  # https://github.com/unpluggedcoder/awesome-rust-tools
  home.packages = [
    pkgs.asdf-vm
    pkgs.aws-vault
    pkgs.bottom
    pkgs.btop
    pkgs.cachix
    pkgs.coreutils
    pkgs.devenv
    pkgs.easyrsa
    pkgs.entr
    pkgs.fd
    pkgs.fira-code-nerdfont
    pkgs.gnumake
    pkgs.jq
    pkgs.minikube
    pkgs.noti
    pkgs.pstree
    pkgs.rename
    pkgs.tailspin
    pkgs.terminal-notifier
    pkgs.tmate
    pkgs.tree
    pkgs.watch
    pkgs.wget
    pkgs.yq
  ];

  home.sessionVariables.SHELL = "${pkgs.fish}/bin/fish";

  programs.direnv.enable = true;

  programs.fzf.enable = true;

  programs.gh = {
    enable = true;
    settings.git_protocol = "git";
  };

  programs.hmd.enable = true;

  programs.lsd = {
    enable = true;
    enableAliases = true;
    # https://github.com/lsd-rs/lsd#config-file-content
    settings.color.when = "never";
  };

  programs.fish = {
    enable = true;
    functions.fish_greeting = "";
    shellInit = ''
       # https://github.com/Homebrew/brew/blob/master/Library/Homebrew/cmd/shellenv.sh
       eval (/opt/homebrew/bin/brew shellenv)
      . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    '';
  };

  programs.starship.enable = true;

  programs.zoxide.enable = true;
}
