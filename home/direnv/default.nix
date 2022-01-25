{ pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    nix-direnv.enable = true;
  };
}
