{ pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    # config
    defaultCommand = "${pkgs.ripgrep}/bin/rg --files --hidden";
    enableBashIntegration = false;
    enableFishIntegration = true;
    enableZshIntegration = false;
  };

  home.file.".rgignore".text = ''
    .direnv/
    .git/
  '';
}
