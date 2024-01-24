{ pkgs, ... }:

[
  {
    # TODO: look for a replacement https://github.com/rockerBOO/awesome-neovim#formatting
    plugin = pkgs.vimPlugins.vim-better-whitespace;
    config = ''
      let g:strip_whitespace_on_save = 1
    '';
  }
]
