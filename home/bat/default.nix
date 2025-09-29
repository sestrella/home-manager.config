{ ... }:

{
  programs.bat = {
    enable = true;
    config.theme = "Solarized (light)";
  };

  programs.fish.shellAbbrs.cat = "bat";
}
