{ pkgs }:

{
  plugin = pkgs.vimPlugins.vim-better-whitespace;
  config = ''
    let g:strip_whitespace_on_save = 1
  '';
}
