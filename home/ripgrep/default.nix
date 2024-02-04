{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.ripgrep
  ];

  programs.fish.shellAbbrs.grep = "rg";
}
