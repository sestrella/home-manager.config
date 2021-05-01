{ pkgs, config, ... }:

let
  shareDir = "${config.home.homeDirectory}/.local/share";
in {
  home.packages = [
    pkgs.spotify
  ];

  home.file = {
    "${shareDir}/applications/spotify.desktop".source = "${pkgs.spotify}/share/applications/spotify.desktop";
    # TODO: refactor
    "${shareDir}/icons/hicolor/16x16/apps/spotify-client.png".source = "${pkgs.spotify}/share/icons/hicolor/16x16/apps/spotify-client.png";
    "${shareDir}/icons/hicolor/22x22/apps/spotify-client.png".source = "${pkgs.spotify}/share/icons/hicolor/22x22/apps/spotify-client.png";
    "${shareDir}/icons/hicolor/24x24/apps/spotify-client.png".source = "${pkgs.spotify}/share/icons/hicolor/24x24/apps/spotify-client.png";
    "${shareDir}/icons/hicolor/32x32/apps/spotify-client.png".source = "${pkgs.spotify}/share/icons/hicolor/32x32/apps/spotify-client.png";
    "${shareDir}/icons/hicolor/48x48/apps/spotify-client.png".source = "${pkgs.spotify}/share/icons/hicolor/48x48/apps/spotify-client.png";
    "${shareDir}/icons/hicolor/64x64/apps/spotify-client.png".source = "${pkgs.spotify}/share/icons/hicolor/64x64/apps/spotify-client.png";
    "${shareDir}/icons/hicolor/128x128/apps/spotify-client.png".source = "${pkgs.spotify}/share/icons/hicolor/128x128/apps/spotify-client.png";
    "${shareDir}/icons/hicolor/256x256/apps/spotify-client.png".source = "${pkgs.spotify}/share/icons/hicolor/256x256/apps/spotify-client.png";
    "${shareDir}/icons/hicolor/512x512/apps/spotify-client.png".source = "${pkgs.spotify}/share/icons/hicolor/512x512/apps/spotify-client.png";
  };
}
