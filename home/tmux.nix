{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    # config
    baseIndex = 1;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    extraConfig = ''
      set-option -sa terminal-overrides ',xterm-256color:RGB'
    '';
    keyMode = "vi";
    # https://github.com/rothgar/awesome-tmux
    plugins = [
      pkgs.tmuxPlugins.nord
    ];
    shortcut = "a";
    terminal = "screen-256color";
  };
}
