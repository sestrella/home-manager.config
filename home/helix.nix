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

    HELIX_THEME_DIR="${config.programs.helix.package}/lib/runtime/themes"
    DARK_THEME="$HELIX_THEME_DIR/solarized_dark.toml"
    LIGHT_THEME="$HELIX_THEME_DIR/solarized_light.toml"

    log "Starting helix theme sync daemon"
    log "THEME_DIR: $THEME_DIR"
    log "DARK_THEME: $DARK_THEME"
    log "LIGHT_THEME: $LIGHT_THEME"

    log() {
      printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1"
    }

    cleanup() {
      log "Received shutdown signal, exiting gracefully"
      exit 0
    }

    trap cleanup SIGTERM SIGINT

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

      log "Applying theme: $mode -> $target"
      mkdir -p "$THEME_DIR"

      if [[ "$(readlink "$LINK" 2>/dev/null || true)" != "$target" ]]; then
        log "Linking $LINK to $target"
        ln -sf "$target" "$LINK"
        log "Signaling helix with USR1"
        pkill -USR1 hx || log "Warning: helix not running"
      else
        log "Theme already linked correctly"
      fi
    }

    last_mode=""

    while true; do
      current_mode="$(get_mode)"

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
      StandardOutPath = "${config.home.homeDirectory}/.local/state/helix-theme-sync.log";
      StandardErrPath = "${config.home.homeDirectory}/.local/state/helix-theme-sync.log";
    };
  };
}
