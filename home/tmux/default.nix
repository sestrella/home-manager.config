{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    extraConfig = ''
      set -g default-command "${lib.getExe config.programs.fish.package}"
      set -sa terminal-overrides ",xterm-256color:RGB"
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
      {
        # TODO: Install dark-notify via Nix
        # https://github.com/cormacrelf/dark-notify
        plugin = pkgs.tmuxPlugins.mkTmuxPlugin rec {
          pluginName = "tmux-dark-notify";
          version = "23b27ed6cc8880960db49c69ca1bca7616348965";
          rtpFilePath = "main.tmux";
          src = pkgs.fetchFromGitHub {
            owner = "erikw";
            repo = pluginName;
            rev = version;
            hash = "sha256-dTtgWPZpu02BNuJ4QgXLXKpw/fSvDBZkLdqRKKCRBRA";
          };
        };
        extraConfig =
          let
            path = "${pkgs.tmuxPlugins.tmux-colors-solarized}/share/tmux-plugins/tmuxcolors";
          in
          ''
            set -g @dark-notify-theme-path-dark '${path}/tmuxcolors-dark.conf'
            set -g @dark-notify-theme-path-light '${path}/tmuxcolors-light.conf'
          '';
      }
      {
        plugin = pkgs.tmuxPlugins.tmux-fzf;
        extraConfig = ''
          TMUX_FZF_PREVIEW=0
          bind-key "s" run-shell -b "${pkgs.tmuxPlugins.tmux-fzf}/share/tmux-plugins/tmux-fzf/scripts/session.sh switch"
        '';
      }
    ];
    shortcut = "a";
    terminal = "xterm-256color";
    tmuxinator.enable = true;
  };

  programs.fish.shellAbbrs = {
    # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/tmux
    t = "tmuxinator";
    ta = "tmux attach -t (tmux list-sessions -F '#{session_name}' | fzf)";
    tkss = "tmux kill-session -t";
    tksv = "tmux kill-server";
    tl = "tmux list-sessions";
    ts = "tmux new-session -s";
  };
}
