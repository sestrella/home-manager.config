{ ... }:

{
  imports = [ ./module.nix ];

  programs.spotify = {
    enable = true;
    users = {
      "sebastian.estrella" = {
        uiTrackNotificationsEnabled = false;
      };
    };
  };
}
