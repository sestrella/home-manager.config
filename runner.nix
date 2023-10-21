{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "runner";
  home.homeDirectory = "/home/runner";

  imports = [ ./home.nix ];
}
