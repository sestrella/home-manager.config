{ pkgs, ... }:

{
  programs.zsh ={
    enable = true;
    initExtraFirst = ''
      . ~/.nix-profile/etc/profile.d/nix.sh
    '';
    shellAliases = {
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
