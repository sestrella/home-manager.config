{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    # config
    font = {
      name = "Fira Code";
      package = pkgs.fira-code;
    };
    settings = {
      font_size = 12;
      enable_audio_bell = false;
    };
    extraConfig = ''
      include ./kitty-themes/themes/Solarized_Dark.conf
    '';
  };
}
