{ pkgs, ... }:

[
  {
    plugin = pkgs.vimPlugins.CopilotChat-nvim;
    config = builtins.readFile ./config.lua;
    type = "lua";
  }
]
