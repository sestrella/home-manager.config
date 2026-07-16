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

  # TODO: Remove once https://github.com/nix-community/home-manager/pull/9662 gets merged
  xdg.configFile."herdr/config.toml".onChange =
    "${lib.getExe config.programs.herdr.package} server reload-config || true";
}
