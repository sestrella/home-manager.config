{ pkgs, ... }:

{
  imports = [
    ./home/direnv
    ./home/fish
    # ./home/ghci
    ./home/git
    ./home/gnome
    ./home/neovim
    ./home/spotify
    ./home/starship
    # ./home/tmux
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
  home.stateVersion = "20.09";

  home.packages = with pkgs; [
    bind
    docker-compose
    file
    github-cli
    # google-chrome
    htop
    jq
    lshw
    lsof
    ncat
    ngrok
    openssl
    pciutils
    # postman
    ripgrep
    # slack
    spotify
    tmate
    traceroute
    wavemon
    wget
    wirelesstools
    xclip
    yq
    # zoom-us
  ];

  news.display = "silent";
}
