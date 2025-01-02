{ config, ... }:

{
  programs.ghostty = {
    enable = true;
    installBatSyntax = false;
    settings = {
      command = "${config.programs.fish.package}/bin/fish";
      font-family = "FiraCode Nerd Font Mono";
      font-size = 16;
      font-style = "SemiBold";
      theme = "light:Violet Light,dark:Violet Dark";
    };
  };
}
