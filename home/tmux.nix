{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    extraConfig = ''
      set-option -sa terminal-overrides ",xterm-256color:RGB"
    '';
    keyMode = "vi";
    shortcut = "a";
    terminal = "screen-256color";
  };

  programs.fish.shellAbbrs = {
    # tmux - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/tmux
    ta = "tmux attach -t";
    tkss = "tmux kill-session -t";
    tksv = "tmux kill-server";
    tl = "tmux list-sessions";
    ts = "tmux new-session -s";
  };
}
