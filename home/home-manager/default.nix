{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  programs.fish.shellAbbrs.hms = "home-manager switch";
}
