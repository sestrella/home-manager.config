{ lib, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font.normal = {
        family = "FiraCode Nerd Font Mono";
        style = "Medium";
      };
      font.size = 16;
      general.import = [ "~/.config/alacritty/theme.toml" ];
      terminal.shell.program = "${pkgs.fish}/bin/fish";
    };
  };

  # TODO: Call the same script on the alacritty agent
  home.activation.alacrittyTheme = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    theme() {
      local style=$(/usr/bin/defaults read -g AppleInterfaceStyle 2> /dev/null || echo "Light")
      if [ "$style" == "Dark" ]; then
        echo "${pkgs.alacritty-theme}/solarized_dark.toml"
      else
        echo "${pkgs.alacritty-theme}/solarized_light.toml"
      fi
    }

    mkdir -p ~/.config/alacritty
    ln -sf "$(theme)" ~/.config/alacritty/theme.toml
  '';

  # TODO: Install dark-notify via nix
  launchd.agents.alacritty.enable = true;
  launchd.agents.alacritty.config = {
    ProgramArguments =
      let
        alacrittyTheme = pkgs.writeScriptBin "alacritty-theme" ''
          if [ "$1" == "dark" ]; then
            ln -sf "${pkgs.alacritty-theme}/solarized_dark.toml" ~/.config/alacritty/theme.toml
          else
            ln -sf "${pkgs.alacritty-theme}/solarized_light.toml" ~/.config/alacritty/theme.toml
          fi
          touch -h ~/.config/alacritty/alacritty.toml
        '';
      in
      [
        "/opt/homebrew/bin/dark-notify"
        "-c"
        "${alacrittyTheme}/bin/alacritty-theme"
      ];
  };
}
