{ pkgs }:

let
  sources = import ./nix/sources.nix {};
  mkPlugin = ({ name } : pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = name;
    version = sources."${name}".rev;
    src = sources."${name}";
  });
in [
  # nord
  (mkPlugin { name = "nord"; })
]
