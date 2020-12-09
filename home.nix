{ config, pkgs, ... }:

{
  imports = [
    ./programs/fish.nix
    ./programs/git.nix
    ./programs/gnome.nix
    ./programs/google-chrome.nix
    ./programs/home-manager.nix
    ./programs/neovim.nix
    ./programs/starship.nix
    ./programs/tmux.nix
  ];

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
  home.stateVersion = "21.03";

  home.packages = with pkgs; [
    bat
    jq
    ripgrep
    slack
    spotify
    zoom-us
  ];
}
