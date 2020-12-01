{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "sestrella";
  home.homeDirectory = "/home/sestrella";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";

  home.packages = [
    pkgs.bat
  ];

  programs.git = {
    enable = true;
    # config
    userEmail = "2049686+sestrella@users.noreply.github.com";
    userName = "Sebastián Estrella";
  };

  programs.neovim = {
    enable = true;
    # config
    extraConfig = ''
      set expandtab
      set shiftwidth=2
      set softtabstop=2
      set tabstop=2
    '';
  };
}
