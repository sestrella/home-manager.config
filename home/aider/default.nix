{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = [
    (pkgs.writeScriptBin "aider" ''
      set -euo pipefail

      # Path to the apps.json file (adjust if needed)
      CONFIG_PATH="$HOME/.config/github-copilot/apps.json"
      if [[ ! -f "$CONFIG_PATH" ]]; then
          echo "Could not find $CONFIG_PATH. Please check the path and try again." >&2
          exit 1
      fi

      # Extract the first oauth_token using jq
      export GITHUB_COPILOT_TOKEN=$(jq -r 'to_entries[0].value.oauth_token' "$CONFIG_PATH")
      if [[ -z "$GITHUB_COPILOT_TOKEN" || "$GITHUB_COPILOT_TOKEN" == "null" ]]; then
          echo "No oauth_token found in the first entry of $CONFIG_PATH." >&2
          exit 1
      fi

      # Inform the user
      echo "GITHUB_COPILOT_TOKEN is set for this session."

      # Launch aider with the environment variable set
      echo "Starting aider..."
      exec ${lib.getExe pkgs.aider-chat} "$@"
    '')
  ];

  home.file."${config.home.homeDirectory}/.aider.conf.yml".text = ''
    openai-api-base: https://api.githubcopilot.com
    model: openai/gpt-4o
    weak-model: openai/gpt-4o-mini
    show-model-warnings: false
  '';
}
