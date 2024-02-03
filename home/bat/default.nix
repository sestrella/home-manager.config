{ config, pkgs, ... }:

{
  programs.bat.enable = true;

  programs.fish.shellAbbrs.cat = "bat";
}
