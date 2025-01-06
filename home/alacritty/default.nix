{
  config,
  pkgs,
  lib,
  ...
}:

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
      terminal.shell.program = lib.getExe config.programs.fish.package;
    };
  };

  # TODO: Install dark-notify via nix
  launchd.agents.alacritty-theme = {
    enable = true;
    config = {
      ProgramArguments =
        let
          script = pkgs.writeScriptBin "alacritty-theme" ''
            if [ "$1" == "dark" ]; then
              ln -sf ${pkgs.alacritty-theme}/solarized_dark.toml ~/.config/alacritty/theme.toml
            else
              ln -sf ${pkgs.alacritty-theme}/solarized_light.toml ~/.config/alacritty/theme.toml
            fi
            touch -h ~/.config/alacritty/alacritty.toml
          '';
        in
        [
          "/opt/homebrew/bin/dark-notify"
          "-c"
          "${script}/bin/alacritty-theme"
        ];
      RunAtLoad = true;
      KeepAlive = {
        Crashed = true;
        SuccessfulExit = false;
      };
    };
  };
}
