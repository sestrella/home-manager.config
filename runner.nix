{ ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.homeDirectory = "/Users/runner";
  home.username = "runner";

  imports = [ ./home.nix ];
}
