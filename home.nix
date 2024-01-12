{ config, pkgs, ... }:

{
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Custom configuration
  imports = [
    ./home/bat.nix
    ./home/git.nix
    ./home/home-manager.nix
    ./home/neovim.nix
    ./home/ripgrep.nix
    ./home/tmux.nix
  ];

  fonts.fontconfig.enable = true;

  # https://github.com/unpluggedcoder/awesome-rust-tools
  home.packages =
    let
      hrvst-cli = pkgs.buildNpmPackage rec {
        pname = "hrvst-cli";
        version = "2.0.1";

        src = pkgs.fetchFromGitHub {
          owner = "kgajera";
          repo = "hrvst-cli";
          rev = "v${version}";
          hash = "sha256-Xq0q5K0BniVv4AGcEGMFG/rAhvdMy1+to1+9gow2MaA=";
        };

        npmDepsHash = "sha256-Grx3szP5oFpMCr+dWFPmo0V7RRFrltjxGtbz7CAxUEo=";
      };
    in
    [
      hrvst-cli
      pkgs.aws-vault
      pkgs.awscli2
      pkgs.bottom
      pkgs.btop
      pkgs.cachix
      pkgs.devenv
      pkgs.fira-code-nerdfont
      pkgs.jq
      pkgs.nix-index
      pkgs.nix-prefetch
      pkgs.nixpkgs-fmt
      pkgs.noti
      pkgs.pstree
      pkgs.tailspin
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
    shellInit = ''
       # https://github.com/Homebrew/brew/blob/master/Library/Homebrew/cmd/shellenv.sh
       eval (/opt/homebrew/bin/brew shellenv)
      . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    '';
  };

  programs.starship.enable = true;

  programs.kitty = {
    enable = true;
    font.name = "FiraCode Nerd Font Mono";
    font.size = 16;
    settings.shell = "${pkgs.fish}/bin/fish";
    theme = "Solarized Dark";
  };
}
