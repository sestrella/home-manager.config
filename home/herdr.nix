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
      onboarding = false;
      terminal.default_shell = lib.getExe config.programs.fish.package;
      theme = {
        auto_switch = true;
        name = "solarized";
      };
      ui = {
        sidebar_collapsed_mode = "hidden";
        sidebar_start_collapsed = true;
      };
      update.version_check = false;
    };
  };
}
