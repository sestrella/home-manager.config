{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    # config
    baseIndex = 1;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    keyMode = "vi";
    plugins = [
      pkgs.tmuxPlugins.continuum
      pkgs.tmuxPlugins.nord
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
