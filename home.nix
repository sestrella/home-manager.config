{ config, pkgs, ... }:

let
  # https://nixos.wiki/wiki/Fonts#Installing_specific_fonts_from_nerdfonts
  nerdfonts = pkgs.nerdfonts.override {
    fonts = ["FiraCode"];
  };
in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  # INFO: set via flake.nix
  # home.username = "sestrella";
  # home.homeDirectory = "/Users/sestrella";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  # home.stateVersion = "21.11";

  # Custom changes
  imports = [
    ./home/direnv
    ./home/git
    ./home/iterm2
    ./home/neovim
    ./home/stack
    ./home/tmux
    ./home/zsh
  ];

  home.packages = [
    nerdfonts
    pkgs.awscli2
    pkgs.docker-compose
    pkgs.duf
    pkgs.fd
    pkgs.git-ignore
    pkgs.github-cli
    pkgs.htop
    pkgs.jq
    pkgs.ncat
    pkgs.ngrok
    pkgs.niv
    pkgs.ripgrep
    pkgs.vagrant
    pkgs.vscode
    pkgs.watch
    pkgs.wget
    pkgs.yq
  ];

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[➜](bold green) ";
        error_symbol = "[✗](bold red) ";
      };
    };
  };

  programs.fzf.enable = true;

  home.file.".bundle/config".text = ''
    ---
    BUNDLE_PATH: "vendor/bundle"
  '';

  # https://blog.ramdoot.in/changing-ghci-prompt-96fe5750d78
  home.file.".ghci".text = ''
    :set prompt "\ESC[34mλ> \ESC[m"
  '';

  nixpkgs.config.allowUnfree = true;
}
