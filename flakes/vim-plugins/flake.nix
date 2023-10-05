{
  inputs = {
    auto-dark-mode.flake = false;
    auto-dark-mode.url = "github:f-person/auto-dark-mode.nvim";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = inputs: inputs.flake-utils.lib.eachDefaultSystem (system:
    let pkgs = inputs.nixpkgs.legacyPackages.${system};
    in
    rec {
      packages = {
        auto-dark-mode = pkgs.vimUtils.buildVimPlugin {
          name = "auto-dark-mode.nvim";
          src = inputs.auto-dark-mode;
        };
      };

      overlays.default = (final: prev: {
        vimPlugins = prev.vimPlugins // { inherit (packages) auto-dark-mode; };
      });
    }
  );
}
