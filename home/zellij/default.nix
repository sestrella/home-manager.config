{ config, lib, ... }:

{
  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings.default_shell = lib.getExe config.programs.fish.package;
  };

  programs.fish.shellAbbrs = {
    za = "zellij attach";
    zk = "zellij kill-session";
    zls = "zellij list-sessions";
  };
}
