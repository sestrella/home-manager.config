{ config, pkgs, ... }:

{
  programs.gnome-terminal = {
    enable = true;
    # config
    profile = {
      "7f987b3a-0157-48a5-a06f-e2a1d1bb35df" = {
        colors = {
          backgroundColor = "rgb(0,43,54)";
          foregroundColor = "rgb(131,148,150)";
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
        };
        default = true;
        visibleName = "sestrella";
      };
    };
  };
}
