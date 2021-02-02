{ pkgs, ... }:

let
  nord = pkgs.tmuxPlugins.mkDerivation {
    pluginName = "nord-tmux";
    rtpFilePath = "nord.tmux";
    version = "2021-02-01";
    src = pkgs.fetchFromGitHub {
      owner = "arcticicestudio";
      repo = "nord-tmux";
      rev = "4e2dc2a5065f5e8e67366700f803c733682e8f8c";
      sha256 = "0l97cqbnq31f769jak31ffb7bkf8rrg72w3vd0g3fjpq0717864a";
    };
  };
in {
  programs.tmux = {
    enable = true;
    # config
    baseIndex = 1;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    keyMode = "vi";
    plugins = [
      nord
      pkgs.tmuxPlugins.prefix-highlight
      pkgs.tmuxPlugins.resurrect
      pkgs.tmuxPlugins.sensible
    ];
    shortcut = "a";
  };
}
