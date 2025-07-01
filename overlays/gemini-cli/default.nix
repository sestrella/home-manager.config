final: prev: {
  gemini-cli = prev.gemini-cli.overrideAttrs (_: rec {
    version = "0.1.7";
    src = prev.fetchFromGitHub {
      owner = "google-gemini";
      repo = "gemini-cli";
      rev = "v${version}";
      hash = "sha256-DAenod/w9BydYdYsOnuLj7kCQRcTnZ81tf4MhLUug6c=";
    };
    npmDeps = prev.fetchNpmDeps {
      inherit src;
      hash = "sha256-otogkSsKJ5j1BY00y4SRhL9pm7CK9nmzVisvGCDIMlU=";
    };
  });
}
