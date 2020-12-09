{ config, pkgs, ... }:

{
  home.sessionVariables = {
    NIX_PATH = "$HOME/.nix-defexpr/channels:$NIX_PATH";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
