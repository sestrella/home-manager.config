{ pkgs, ... }:

{
  imports = [
    ./home/direnv
    ./home/fish
    ./home/fzf
    ./home/ghci
    ./home/git
    ./home/gnome
    ./home/neovim
    ./home/ripgrep
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

  home.packages = with pkgs; [
    # google-chrome
    # postman
    # slack
    # zoom-us
    bind
    docker-compose
    file
    fira-code
    github-cli
    htop
    jq
    lshw
    lsof
    ncat
    ngrok
    niv
    openssl
    pciutils
    ranger
    rsync
    spotify
    tmate
    traceroute
    vscode
    wavemon
    wget
    wirelesstools
    xclip
    yq
  ];

  news.display = "silent";

  fonts.fontconfig.enable = true;
}
