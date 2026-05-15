{
  config,
  lib,
  pkgs,
  ...
}:

let
  helixThemeSync = pkgs.writeShellScriptBin "helix-theme-sync" ''
    set -euo pipefail

    THEME_DIR="$HOME/.config/helix/themes"
    LINK="$THEME_DIR/solarized.toml"

    FOO="${config.programs.helix.package}/lib/runtime/themes"
    DARK_THEME="$FOO/solarized_dark.toml"
    LIGHT_THEME="$FOO/solarized_light.toml"

    echo "[helix-theme-sync] Starting helix theme sync daemon"
    echo "[helix-theme-sync] THEME_DIR: $THEME_DIR"
    echo "[helix-theme-sync] DARK_THEME: $DARK_THEME"
    echo "[helix-theme-sync] LIGHT_THEME: $LIGHT_THEME"

    get_mode() {
      if defaults read -g AppleInterfaceStyle &>/dev/null; then
        echo dark
      else
        echo light
      fi
    }

    apply_theme() {
      local mode="$1"
      local target

      if [[ "$mode" == "dark" ]]; then
        target="$DARK_THEME"
      else
        target="$LIGHT_THEME"
      fi

      echo "[helix-theme-sync] Applying theme: $mode -> $target"
      mkdir -p "$THEME_DIR"

      if [[ "$(readlink "$LINK" 2>/dev/null || true)" != "$target" ]]; then
        echo "[helix-theme-sync] Linking $LINK to $target"
        ln -sf "$target" "$LINK"
        echo "[helix-theme-sync] Signaling helix with USR1"
        pkill -USR1 hx || echo "[helix-theme-sync] Warning: helix not running"
      else
        echo "[helix-theme-sync] Theme already linked correctly"
      fi
    }

    last_mode=""

    while true; do
      current_mode="$(get_mode)"
      echo "[helix-theme-sync] Current mode: $current_mode (last: $last_mode)"

      if [[ "$current_mode" != "$last_mode" ]]; then
        apply_theme "$current_mode"
        last_mode="$current_mode"
      fi

      sleep 2
    done
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
  xdg.configFile."helix/config.toml".onChange = "/usr/bin/pkill -USR1 hx || true";

  launchd.agents.helix-theme-sync = {
    enable = true;

    config = {
      Program = lib.getExe helixThemeSync;
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = /Users/sestrella/.local/state/helix-theme-sync.log;
      StandardErrPath = /Users/sestrella/.local/state/helix-theme-sync.log;
    };
  };
}
