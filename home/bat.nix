{ config, pkgs, ... }:

{
  programs.bat.enable = true;

  programs.zsh.shellGlobalAliases = {
    cat = "bat";
  };
}
