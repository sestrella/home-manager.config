{ config, pkgs, ... }:

{
  programs.bat.enable = true;

  programs.zsh.shellAliases = {
    cat = "bat";
  };
}
