{ pkgs, ... }:

[
  {
    plugin = pkgs.vimPlugins.comment-nvim;
    config = ''
      require("Comment").setup()
    '';
    type = "lua";
  }
]
