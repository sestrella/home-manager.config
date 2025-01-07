{ ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.homeDirectory = "/Users/sestrella";
  home.username = "sestrella";

  imports = [ ./home.nix ];
}
