{ config, pkgs, ... }:

let
  unstable = import (import ../nix/sources.nix {}).nixpkgs {};
in {
  programs.tmux = {
    enable = true;
    # config
    baseIndex = 1;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    keyMode = "vi";
    plugins = [
      pkgs.tmuxPlugins.continuum
      unstable.tmuxPlugins.nord
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
