{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    # config
    baseIndex = 1;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    extraConfig = ''
      set-option -ga terminal-overrides ",screen-256color:RGB"
    '';
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      nord
      prefix-highlight
      resurrect
      sensible
    ];
    shell = "${pkgs.fish}/bin/fish";
    shortcut = "a";
    terminal = "screen-256color";
  };
}
