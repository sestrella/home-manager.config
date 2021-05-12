{ pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    # config
    defaultCommand = "${pkgs.ripgrep}/bin/rg --files --hidden --no-ignore-vcs";
    enableBashIntegration = false;
    enableFishIntegration = true;
    enableZshIntegration = false;
  };
}
