{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      # cargo
      # cb = "cargo build";
      # cr = "cargo run";
      # duf
      # duf = "command duf -theme $((defaults read -g AppleInterfaceStyle &> /dev/null) && echo \"dark\" || echo \"light\")";
      # fd
      # find = "fd";
      # git - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
      "gc!" = "git commit -v --amend";
      "gp!" = "git push -f";
      ga = "git add";
      gaa = "git add --all";
      gbr = "git branch --remote";
      gc = "git commit -v";
      gco = "git checkout";
      gd = "git diff";
      gl = "git pull";
      gp = "git push";
      gst = "git status";
      # home-manager
      hms = "home-manager switch";
      # tmux - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/tmux
      ta = "tmux attach -t";
      tkss = "tmux kill-session -t";
      tksv = "tmux kill-server";
      tl = "tmux list-sessions";
      ts = "tmux new-session -s";
    };
  };
}
