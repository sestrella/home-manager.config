{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.herdr = {
    enable = true;

    package = pkgs.herdr;

    settings = {
      terminal.default_shell = lib.getExe config.programs.fish.package;
      theme.name = "solarized";
      ui.sidebar_collapsed_mode = "hidden";
      update.version_check = false;
    };
  };
}
