{ pkgs, ... }:

{
  programs.fzf = {
    defaultCommand = "${pkgs.ripgrep}/bin/rg --files --hidden";
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = true;
    enableZshIntegration = false;
  };
}
