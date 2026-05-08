{ pkgs, ... }:

let
  listDirFiles = path: map (name: "${path}/${name}") (builtins.attrNames (builtins.readDir path));
in
{
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # Custom configuration
  imports = listDirFiles ./home;

  home.packages = [
    pkgs.aws-vault
    pkgs.awscli2
    pkgs.nerd-fonts.fira-code
    pkgs.ssm-session-manager-plugin
    pkgs.tree
  ];

  programs.direnv.enable = true;

  programs.gh.enable = true;

  programs.starship.enable = true;
}
