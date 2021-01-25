{ lib, ... }:

let
  mkTuple = lib.hm.gvariant.mkTuple;
  profileId = "7f987b3a-0157-48a5-a06f-e2a1d1bb35df";
in {
  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      current = "uint32 0";
      sources = [
        (mkTuple [ "xkb" "us" ])
        (mkTuple [ "xkb" "latam" ])
      ];
      xkb-options = [
        "terminate:ctrl_alt_bksp"
        "lv3:ralt_switch"
        "caps:ctrl_modifier"
      ];
    };
    "org/gnome/desktop/interface" = {
      gtk-im-module = "gtk-im-context-simple";
      gtk-theme = "Adwaita-dark";
    };
    "org/gnome/terminal/legacy/profiles:" = {
      default = profileId;
      list = [ profileId ];
    };
    "org/gnome/terminal/legacy/profiles:/:${profileId}" = {
      audible-bell = false;
      background-color = "rgb(0,43,54)";
      backspace-binding = "ascii-delete";
      bold-color-same-as-fg = true;
      bold-is-bright = false;
      cursor-blink-mode = "system";
      cursor-colors-set = false;
      cursor-shape = "block";
      delete-binding = "delete-sequence";
      font = "Monospace 12";
      foreground-color = "rgb(131,148,150)";
      highlight-colors-set = false;
      login-shell = false;
      palette = [
        "rgb(7,54,66)"
        "rgb(220,50,47)"
        "rgb(133,153,0)"
        "rgb(181,137,0)"
        "rgb(38,139,210)"
        "rgb(211,54,130)"
        "rgb(42,161,152)"
        "rgb(238,232,213)"
        "rgb(0,43,54)"
        "rgb(203,75,22)"
        "rgb(88,110,117)"
        "rgb(101,123,131)"
        "rgb(131,148,150)"
        "rgb(108,113,196)"
        "rgb(147,161,161)"
        "rgb(253,246,227)"
      ];
      scrollback-lines = 10000;
      scrollbar-policy = "always";
      use-custom-command = false;
      use-system-font = false;
      use-theme-colors = false;
      visible-name = "sestrella";
    };
    "org/gnome/shell" = {
      favorite-apps = [
        "google-chrome.desktop"
        "org.gnome.Terminal.desktop"
        "spotify.desktop"
        "slack.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };
  };
}
