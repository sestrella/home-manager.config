{ mkPlugin }:

let
  sources = import ./nix/sources.nix {};
in [
  # nord
  (mkPlugin {
    pluginName = "nord";
    version = sources.nord.rev;
    src = sources.nord;
  })
]
