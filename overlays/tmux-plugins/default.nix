final: prev: {
  tmuxPlugins = prev.tmuxPlugins // {
    tmux-dark-notify = prev.tmuxPlugins.mkTmuxPlugin {
      pluginName = "tmux-dark-notify";
      rtpFilePath = "main.tmux";
      src = prev.fetchFromGitHub {
        owner = "erikw";
        repo = "tmux-dark-notify";
        rev = "59a6789f0a4f0d86e5b69629750f35905a7f1a88";
        hash = prev.lib.fakeHash;
      };
    };
  };
}
