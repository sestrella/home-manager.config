{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.ripgrep
  ];

  programs.zsh.shellGlobalAliases = {
    grep = "rg";
  };
}
