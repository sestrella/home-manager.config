{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.spotify;

  userSubModule = types.submodule {
    options = {
      uiTrackNotificationsEnabled = mkOption {
        type = types.bool;
        default = true;
        description = "Whether to enable track notifications.";
      };
    };
  };
in {
  options.programs.spotify = {
    enable = mkEnableOption "spotify";

    package = mkOption {
      type = types.package;
      default = pkgs.spotify;
      description = "The package to use for the spotify binary.";
    };

    users = mkOption {
      type = types.attrsOf userSubModule;
      default = { };
      description = "foo bar";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile = (mapAttrs' (name: value: nameValuePair "spotify/Users/${name}-user/prefs" {
      text = ''
        ui.track_notifications_enabled=${boolToString value.uiTrackNotificationsEnabled}
      '';
    }) cfg.users);
  };
}
