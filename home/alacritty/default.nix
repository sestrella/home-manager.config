{ lib, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      import = [ "~/.config/alacritty/theme.yml" ];
      font.normal = {
        family = "FiraCode Nerd Font Mono";
        style = "Medium";
      };
      font.size = 16;
      shell.program = "${pkgs.fish}/bin/fish";
    };
  };

  home.activation.alacrittyTheme = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    theme() {
      local style=$(/usr/bin/defaults read -g AppleInterfaceStyle 2> /dev/null || echo "Light")
      if [ "$style" == "Dark" ]; then
        echo "${pkgs.alacritty-theme}/solarized_dark.yaml"
      else
        echo "${pkgs.alacritty-theme}/solarized_light.yaml"
      fi
    }

    ln -sf "$(theme)" ~/.config/alacritty/theme.yml
  '';

  launchd.agents.alacritty.enable = true;
  launchd.agents.alacritty.config = {
    ProgramArguments =
      let
        alacrittyTheme = pkgs.writeScriptBin "alacritty-theme" ''
          if [ "$1" == "dark" ]; then
            ln -sf "${pkgs.alacritty-theme}/solarized_dark.yaml" ~/.config/alacritty/theme.yml
          else
            ln -sf "${pkgs.alacritty-theme}/solarized_light.yaml" ~/.config/alacritty/theme.yml
          fi
          touch -h ~/.config/alacritty/alacritty.yml
        '';
      in
      [
        "/opt/homebrew/bin/dark-notify"
        "-c"
        "${alacrittyTheme}/bin/alacritty-theme"
      ];
  };
}
