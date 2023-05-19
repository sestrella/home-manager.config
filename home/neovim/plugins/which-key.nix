{ pkgs, ... }:

[{
  plugin = pkgs.vimPlugins.which-key-nvim;
  config = ''
    require("which-key").setup()
  '';
  type = "lua";
}]
