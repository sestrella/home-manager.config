{ config, lib, ... }:

{
  # INFO: ghostty package is flagged as broken for Darwin.
  # https://github.com/NixOS/nixpkgs/pull/369788
  config.xdg.configFile."ghostty/config" = {
    text = ''
      command = "${lib.getExe config.programs.fish.package}"
      font-family = "FiraCode Nerd Font Mono"
      font-size = 16
      font-style = "SemiBold"
      theme = "dark:Builtin Solarized Dark,light:Builtin Solarized Light"
      window-width = 95
      window-height = 20
    '';
    onChange = "/opt/homebrew/bin/ghostty +validate-config";
  };
}
