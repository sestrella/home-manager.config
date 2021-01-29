{ pkgs, ... }:

# let
#   kittyThemes = pkgs.stdenv.mkDerivation rec {
#     pname = "kitt-themes";
#     version = "2021-01-29";
#     src = pkgs.fetchFromGitHub {
#       owner = "dexpota";
#       repo = "${pname}";
#       rev = "fca3335489bdbab4cce150cb440d3559ff5400e2";
#       sha256 = "14xhh49izvjw4ycwq5gx4if7a0bcnvgsf3irywc3qps6jjcf5ymk";
#     };
#   };
# in

{
  programs.kitty = {
    enable = true;
    # config
    font = {
      name = "Fira Code";
      package = pkgs.fira-code;
    };
    settings = {
      font_size = 12;
      enable_audio_bell = false;
    };
    extraConfig = ''
      include ~/.config/kitty/kitty-themes/themes/Solarized_Dark.conf
    '';
  };
}
