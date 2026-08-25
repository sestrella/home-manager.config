{
  config,
  lib,
  pkgs,
  ...
}:

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
  home.stateVersion = "26.05"; # Please read the comment before changing.

  home.homeDirectory = "/Users/${config.home.username}";
  home.username = lib.mkDefault "sestrella";

  # Custom configuration
  imports = listDirFiles ./home;

  home.sessionVariables = {
    DEVENV_INCLUDE_ENVRC = 1;
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.packages = [
    pkgs.actionlint
    pkgs.devenv
    pkgs.findutils
    pkgs.gitleaks
    pkgs.gnused
    pkgs.nerd-fonts.fira-code
    pkgs.rename
    pkgs.ripgrep
    pkgs.shellcheck
    pkgs.tree
    pkgs.yq
  ];

  programs = {
    direnv.enable = true;
    gh.enable = true;
  };
}
