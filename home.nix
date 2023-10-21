{ config, pkgs, ... }:

{
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # Custom configuration
  imports = [
    ./home/bat.nix
    ./home/git.nix
    ./home/neovim.nix
    ./home/ripgrep.nix
    ./home/tmux.nix
  ];

  # https://github.com/unpluggedcoder/awesome-rust-tools
  home.packages = [
    pkgs.aws-vault
    pkgs.awscli2
    pkgs.bottom
    pkgs.btop
    pkgs.jq
    pkgs.nix-prefetch-git
    pkgs.pstree
    pkgs.tmate
    pkgs.tree
    pkgs.watch
    pkgs.wget
    pkgs.yq
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

  programs.lsd = {
    enable = true;
    enableAliases = true;
    # https://github.com/lsd-rs/lsd#config-file-content
    settings.color.when = "never";
  };

  programs.fish = {
    enable = true;
    functions.fish_greeting = "";
    shellAbbrs.nfid = ''
      nix flake init --template github:cachix/devenv#flake-parts
    '';
    shellInit = ''
      # https://github.com/Homebrew/brew/blob/master/Library/Homebrew/cmd/shellenv.sh
      eval (/opt/homebrew/bin/brew shellenv)
     . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    '';
  };

  programs.starship.enable = true;

  # nixpkgs.overlays = [
  #   vim-plugins-overlays.default
  # ];
  programs.home-manager.enable = true;
}
