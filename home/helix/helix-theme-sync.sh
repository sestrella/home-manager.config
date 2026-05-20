if [[ -z "$HELIX_RUNTIME_DIR" ]]; then
  echo "Error: HELIX_RUNTIME_DIR is not defined" >&2
  exit 1
fi

THEME_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/helix/themes"
LINK="$THEME_DIR/solarized.toml"

HELIX_THEME_DIR="$HELIX_RUNTIME_DIR/themes"
DARK_THEME="$HELIX_THEME_DIR/solarized_dark.toml"
LIGHT_THEME="$HELIX_THEME_DIR/solarized_light.toml"

log() {
  printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$1"
}

cleanup() {
  log "Received shutdown signal, exiting gracefully"
  exit 0
}

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

trap cleanup SIGTERM SIGINT

log "Starting helix theme sync daemon"
log "THEME_DIR: $THEME_DIR"
log "DARK_THEME: $DARK_THEME"
log "LIGHT_THEME: $LIGHT_THEME"

last_mode=""

while true; do
  current_mode="$(get_mode)"

  if [[ "$current_mode" != "$last_mode" ]]; then
    apply_theme "$current_mode"
    last_mode="$current_mode"
  fi

  sleep 2
done
