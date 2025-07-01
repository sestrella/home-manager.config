final: prev: {
  aider-chat = prev.aider-chat.overrideAttrs (_: rec {
    version = "0.85.0";
    src = prev.fetchFromGitHub {
      owner = "Aider-AI";
      repo = "aider";
      rev = "v${version}";
      hash = "sha256-ZYjDRu4dAOkmz+fMOG8KU6y27RI/t3iEoTSUebundqo=";
    };
  });
}
