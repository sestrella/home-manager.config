{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.ripgrep
  ];

  programs.zsh.shellAliases = {
    grep = "rg";
  };
}
