{ config, lib, ... }:

{
  programs.ghostty = {
    enable = true;
    package = null;
    settings = {
      command = lib.getExe config.programs.fish.package;
      font-family = "FiraCode Nerd Font Mono";
      font-size = 16;
      font-style = "SemiBold";
      theme = "dark:Builtin Solarized Dark,light:Builtin Solarized Light";
    };
  };
}
