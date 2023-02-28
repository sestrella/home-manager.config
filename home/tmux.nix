{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    # https://neovim.io/doc/user/term.html
    extraConfig = ''
      set-option -sa terminal-overrides ",xterm-256color:RGB"
    '';
    keyMode = "vi";
    plugins = [
      {
        # https://github.com/seebi/tmux-colors-solarized
        plugin = pkgs.tmuxPlugins.tmux-colors-solarized;
        extraConfig = ''
          set -g @colors-solarized 'light'
        '';
      }
    ];
    shortcut = "a";
    terminal = "screen-256color";
    tmuxinator.enable = true;
  };

  programs.fish.shellAbbrs = {
    # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/tmux
    ta = "tmux attach -t";
    tkss = "tmux kill-session -t";
    tksv = "tmux kill-server";
    tl = "tmux list-sessions";
    ts = "tmux new-session -s";
  };
}
