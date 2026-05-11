{ config, lib, ... }:

{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    package = null;
    settings = {
      command = lib.getExe config.programs.fish.package;
      font-family = "FiraCode Nerd Font Mono";
      font-size = 16;
      font-style = "SemiBold";
      macos-option-as-alt = true; # Required to support Alt-based keybindings in Helix.
      theme = "dark:iTerm2 Solarized Dark,light:iTerm2 Solarized Light";
    };
  };
}
