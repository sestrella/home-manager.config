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
    plugins = (import ./plugins.nix {
      tmuxPlugin = pkgs.tmuxPlugins.mkTmuxPlugin;
    });
    # plugins = with pkgs.tmuxPlugins; [
    #   nord
    #   prefix-highlight
    #   resurrect
    #   sensible
    # ];
    shell = "${pkgs.fish}/bin/fish";
    shortcut = "a";
    terminal = "screen-256color";
  };
}
