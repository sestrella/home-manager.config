{ config, pkgs, ... }:

{
  home.packages =
    let
      aiderWrapper = pkgs.writeScriptBin "aider" ''
        set -euo pipefail

        # Path to the apps.json file (adjust if needed)
        CONFIG_PATH="$HOME/.config/github-copilot/apps.json"

        if [[ ! -f "$CONFIG_PATH" ]]; then
            echo "Could not find $CONFIG_PATH. Please check the path and try again." >&2
            exit 1
        fi

        # Extract the first oauth_token using jq
        OAUTH_TOKEN=$(jq -r 'to_entries[0].value.oauth_token' "$CONFIG_PATH")
        if [[ -z "$OAUTH_TOKEN" || "$OAUTH_TOKEN" == "null" ]]; then
            echo "No oauth_token found in the first entry of $CONFIG_PATH." >&2
            exit 1
        fi

        # Fetch the Copilot token from GitHub API
        COPILOT_TOKEN=$(curl -s -H "Authorization: Bearer $OAUTH_TOKEN" \
            "https://api.github.com/copilot_internal/v2/token" | jq -r '.token')

        if [[ -z "$COPILOT_TOKEN" || "$COPILOT_TOKEN" == "null" ]]; then
            echo "No 'token' field found in the API response." >&2
            exit 1
        fi

        # Export the token as OPENAI_API_KEY in the current process
        export OPENAI_API_KEY="$COPILOT_TOKEN"

        # Inform the user
        echo "OPENAI_API_KEY is set for this session."

        # Launch aider with the environment variable set
        echo "Starting aider..."
        exec ${pkgs.aider-chat}/bin/aider "$@"
      '';
    in
    [
      aiderWrapper
    ];

  home.file = {
    "${config.home.homeDirectory}/.aider.conf.yml".text = ''
      openai-api-base: https://api.githubcopilot.com
      model: openai/gpt-4o
      weak-model: openai/gpt-4o-mini
      show-model-warnings: false
    '';
    "${config.home.homeDirectory}/.aider.model.settings.yml".text = ''
      - name: openai/gpt-4o
        extra_params:
          api_base: https://api.githubcopilot.com
          extra_headers:
            Editor-Version: ${pkgs.aider-chat.pname}/${pkgs.aider-chat.version}
            Copilot-Integration-Id: vscode-chat
          max_tokens: 8192
    '';
  };
}
