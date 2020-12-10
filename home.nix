{ config, pkgs, ... }:

{
  imports = [
    ./home/fish.nix
    ./home/git.nix
    ./home/gnome.nix
    ./home/google-chrome.nix
    ./home/neovim.nix
    ./home/starship.nix
    ./home/tmux.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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

  home.sessionVariables = {
    NIX_PATH = "$HOME/.nix-defexpr/channels:$NIX_PATH";
  };

  home.packages = with pkgs; [
    bat
    jq
    ripgrep
    slack
    spotify
    zoom-us
  ];

  news.display = "silent";
}
