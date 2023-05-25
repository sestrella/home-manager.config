{ pkgs, ... }:

[
  {
    plugin = pkgs.vimPlugins.hardtime-nvim;
    # https://github.com/m4xshen/hardtime.nvim
    config = ''
      require("hardtime").setup()
    '';
    type = "lua";
  }
]
