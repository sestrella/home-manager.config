{ pkgs, ... }:

[
  {
    plugin = pkgs.vimPlugins.copilot-lua;
    config = builtins.readFile ./config.lua;
    type = "lua";
  }
]
