{ pkgs, ... }:

let
  # TODO: Make this a service instead than testing it on each bootstrap
  helixWrapper = pkgs.writeShellScriptBin "hx" ''
    # Detect macOS system appearance and set theme symlink accordingly
    if command -v defaults &> /dev/null; then
      if [[ $(defaults read -g AppleInterfaceStyle 2> /dev/null) == "Dark" ]]; then
        THEME_FILE="solarized_dark.toml"
      else
        THEME_FILE="solarized_light.toml"
      fi

      # Create themes directory if it doesn't exist
      mkdir -p "$HOME/.config/helix/themes"

      # Update the solarized.toml symlink
      ln -sf "${pkgs.helix}/lib/runtime/themes/$THEME_FILE" "$HOME/.config/helix/themes/solarized.toml"

      # Reload the configuration for all running instances
      pkill -USR1 hx
    fi

    exec ${pkgs.helix}/bin/hx "$@"
  '';
in
{
  programs.helix = {
    enable = true;

    defaultEditor = true;
    extraPackages = [
      pkgs.bash-language-server
      pkgs.docker-compose-language-service
      pkgs.elixir-ls
      pkgs.nixd
      pkgs.nixfmt
      pkgs.terraform-ls
      pkgs.vscode-json-languageserver
      pkgs.yaml-language-server
    ];
    languages = {
      language = [
        {
          name = "elixir";
          auto-format = true;
        }
        {
          name = "nix";
          auto-format = true;
        }
      ];
    };
    package = helixWrapper;
    settings = {
      editor = {
        cursor-shape.insert = "bar";
        file-picker.hidden = false;
        line-number = "relative";
        mouse = false;
        rulers = [ 80 ];
      };
      theme = "solarized";
    };
  };

  # This has already been implemented in the master branch.
  xdg.configFile."helix/config.toml".onChange = "/usr/bin/pkill -USR1 hx";
}
