{ pkgs }:

{
  bluetooth-input-switcher = pkgs.callPackage ./bluetooth-input-switcher { };
  helix-theme-sync = pkgs.callPackage ./helix-theme-sync { };
}
