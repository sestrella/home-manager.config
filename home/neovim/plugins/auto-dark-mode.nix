{ auto-dark-mode, pkgs, ... }:

[
  {
    plugin = pkgs.vimUtils.buildVimPlugin rec {
      name = "auto-dark-mode.nvim";
      src = auto-dark-mode;
    };
    config = builtins.readFile ./auto-dark-mode.lua;
    type = "lua";
  }
]
