{ tmuxPlugin }:

let
  sources = import ./nix/sources.nix {};
in [
  # nord
  (tmuxPlugin {
    pluginName = "nord";
    version = sources.nord.rev;
    src = sources.nord;
  })
]
