{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      push = {
        autoSetupRemote = true;
        default = "simple";
      };
    };
    delta = {
      enable = true;
      options.line-numbers = true;
    };
    userEmail = "2049686+sestrella@users.noreply.github.com";
    userName = "Sebastian Estrella";
  };

  programs.fish.shellAbbrs = {
    "gc!" = "git commit -v --amend";
    "gp!" = "git push --force-with-lease";
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
