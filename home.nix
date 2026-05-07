{
  config,
  lib,
  pkgs,
  ...
}:

{
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # Custom configuration
  imports = [
    ./home/fish
    ./home/ghostty
    ./home/git
    ./home/helix
    ./home/home-manager
  ];

  home.packages = [
    pkgs.aws-vault
    pkgs.awscli2
    pkgs.nerd-fonts.fira-code
    pkgs.ssm-session-manager-plugin
  ];

  programs.direnv.enable = true;

  programs.gh.enable = true;

  programs.starship.enable = true;

  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings.default_shell = lib.getExe config.programs.fish.package;
  };
}
