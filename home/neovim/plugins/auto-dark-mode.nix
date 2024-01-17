{ pkgs, ... }:

[
  {
    plugin = pkgs.vimUtils.buildVimPlugin rec {
      name = "auto-dark-mode.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "f-person";
        repo = name;
        rev = "76e8d40d1e1544bae430f739d827391cbcb42fcc";
        hash = "sha256-uJ4LxczgWl4aQCFuG4cR+2zwhNo7HB6R7ZPTdgjvyfY";
      };
    };
    config = builtins.readFile ./auto-dark-mode.lua;
    type = "lua";
  }
]
