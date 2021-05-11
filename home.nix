{ pkgs, ... }:

let
  sources = import ./nix/sources.nix {};
  niv = import sources.niv {};
in {
  imports = [
    ./home/direnv
    ./home/fish
    ./home/fzf
    ./home/ghci
    ./home/git
    ./home/gnome
    ./home/neovim
    ./home/starship
    ./home/tmux
    ./home/xprofile
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = false;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "sestrella";
  home.homeDirectory = "/home/sestrella";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  home.packages = [
    # google-chrome
    # postman
    # slack
    # zoom-us
    niv
    pkgs.bind
    pkgs.docker-compose
    pkgs.file
    pkgs.fira-code
    pkgs.github-cli
    pkgs.htop
    pkgs.jq
    pkgs.lshw
    pkgs.lsof
    pkgs.ncat
    pkgs.ngrok
    pkgs.niv
    pkgs.openssl
    pkgs.pciutils
    pkgs.ranger
    pkgs.ripgrep
    pkgs.rsync
    pkgs.spotify
    pkgs.tmate
    pkgs.traceroute
    pkgs.vscode
    pkgs.wavemon
    pkgs.wget
    pkgs.wirelesstools
    pkgs.xclip
    pkgs.yq
  ];

  news.display = "silent";

  fonts.fontconfig.enable = true;
}
