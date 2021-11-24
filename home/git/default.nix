{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
      push.default = "current";
    };
    userEmail = "2049686+sestrella@users.noreply.github.com";
    userName = "Sebastian Estrella";
  };
}
