{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    # config
    baseIndex = 1;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    keyMode = "vi";
    plugins = [
      pkgs.tmuxPlugins.nord
      pkgs.tmuxPlugins.prefix-highlight
      pkgs.tmuxPlugins.resurrect
      pkgs.tmuxPlugins.sensible
    ];
    shortcut = "a";
    terminal = "screen-256color";
  };
}