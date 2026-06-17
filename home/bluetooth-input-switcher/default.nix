{
  config,
  lib,
  pkgs,
  ...
}:

let
  bluetoothInputSwitcher = import ./package.nix { inherit pkgs; };
in
{
  launchd.agents.bluetooth-input-switcher = {
    enable = true;

    config = {
      Program = lib.getExe bluetoothInputSwitcher;
      ProcessType = "Background";
      RunAtLoad = true;
      KeepAlive = {
        Crashed = true;
        SuccessfulExit = false;
      };
      StandardOutPath = "${config.home.homeDirectory}/.local/state/bluetooth-input-switcher/logs/out.log";
      StandardErrPath = "${config.home.homeDirectory}/.local/state/bluetooth-input-switcher/logs/err.log";
    };
  };
}
