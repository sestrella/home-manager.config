{ pkgs, ... }:

[{
  plugin = pkgs.vimPlugins.lualine-nvim;
  config = ''
    require('lualine').setup()
  '';
  type = "lua";
}]
