{ config, lib, ... }:

{
  programs.zellij = {
    enable = true;

    settings = {
      default_shell = lib.getExe config.programs.fish.package;
      show_startup_tips = false;
      theme = "solarized";
    };
  };

  programs.fish.shellAbbrs = {
    za = "zellij attach";
    zk = "zellij kill-session";
    zls = "zellij list-sessions";
  };
}
