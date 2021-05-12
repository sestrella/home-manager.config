{ pkgs, ... }:

{
  home.packages = [
    pkgs.ripgrep
  ];

  home.file.".rgignore".text = ''
    .direnv/
    .git/
  '';
}
