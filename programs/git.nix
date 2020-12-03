{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    # config
    userEmail = "2049686+sestrella@users.noreply.github.com";
    userName = "Sebastián Estrella";
  };
}
