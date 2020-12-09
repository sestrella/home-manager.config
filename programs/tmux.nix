{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    # config
    baseIndex = 1;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      continuum
      resurrect
      sensible
    ];
    shortcut = "a";
    terminal = "screen-256color";
  };
}
