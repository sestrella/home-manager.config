{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    extraConfig.init.defaultBranch = "main";
    userEmail = "2049686+sestrella@users.noreply.github.com";
    userName = "Sebastian Estrella";
  };

  programs.zsh.shellAliases = {
    ga = "git add";
    gaa = "git add --all";
    gbr = "git branch --remote";
    gc = "git commit -v";
    gco = "git checkout";
    gd = "git diff";
    gl = "git pull";
    gp = "git push";
    gst = "git status";
  };
}
