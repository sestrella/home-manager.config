{
  config,
  lib,
  pkgs,
  ...
}:
{
  launchd.agents.bluetooth-input-switcher = {
    enable = true;

    config = {
      Program = lib.getExe pkgs.bluetooth-input-switcher;
      ProcessType = "Background";
      RunAtLoad = true;
      KeepAlive = false;
      StandardOutPath = "${config.home.homeDirectory}/.local/state/bluetooth-input-switcher/logs/out.log";
      StandardErrorPath = "${config.home.homeDirectory}/.local/state/bluetooth-input-switcher/logs/err.log";
    };
  };
}
