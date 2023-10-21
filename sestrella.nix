{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "sestrella";
  home.homeDirectory = "/Users/sestrella";

  imports = [ ./home.nix ];
}
