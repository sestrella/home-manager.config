{ ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.homeDirectory = "/Users/sebastian.estrella";
  home.username = "sebastian.estrella";

  imports = [ ./home.nix ];
}
