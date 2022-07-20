{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      hms = "home-manager switch";
    };
  };
}
