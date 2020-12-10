{ config, pkgs, ... }:

let
  nixpkgs = import (import ../nix/sources.nix {}).nixpkgs {};
in {
  programs.tmux = {
    enable = true;
    # config
    baseIndex = 1;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    keyMode = "vi";
    plugins = [
      nixpkgs.tmuxPlugins.nord
      pkgs.tmuxPlugins.continuum
      {
        plugin = pkgs.tmuxPlugins.resurrect;
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      pkgs.tmuxPlugins.sensible
    ];
    shortcut = "a";
    terminal = "screen-256color";
  };
}
