{ config, pkgs, ... }:

let
  # https://nixos.wiki/wiki/Fonts#Installing_specific_fonts_from_nerdfonts
  nerdfonts = pkgs.nerdfonts.override {
    fonts = [ "FiraCode" ];
  };
in
{
  imports = [
    # ./home/bundle
    ./home/direnv
    ./home/fzf
    ./home/git
    # ./home/iterm2
    ./home/neovim
    ./home/starship
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
    pkgs.nixpkgs-fmt
    pkgs.ripgrep
    pkgs.vagrant
    pkgs.watch
    pkgs.yq
  ];

  # programs.fzf.enable = true;

  # https://blog.ramdoot.in/changing-ghci-prompt-96fe5750d78
  # home.file.".ghci".text = ''
  #   :set prompt "\ESC[34mλ> \ESC[m"
  # '';

  nixpkgs.config.allowUnfree = true;
}
