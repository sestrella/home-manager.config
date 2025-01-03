{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      pkgs.ansible-language-server
      pkgs.bash-language-server
      pkgs.docker-compose-language-service
      pkgs.golangci-lint-langserver
      pkgs.gopls
      pkgs.marksman
      pkgs.nil
      pkgs.terraform-ls
      pkgs.yaml-language-server
    ];
    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
          };
        }
      ];
    };
    settings = {
      theme = "solarized";
    };
  };

  home.activation.helixTheme = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p ~/.config/helix/themes
    style=$(/usr/bin/defaults read -g AppleInterfaceStyle 2> /dev/null || echo "Light")
    if [ "$style" == "Dark" ]; then
      ln -sf ${config.programs.helix.package}/lib/runtime/themes/solarized_dark.toml ~/.config/helix/themes/solarized.toml
    else
      ln -sf ${config.programs.helix.package}/lib/runtime/themes/solarized_light.toml ~/.config/helix/themes/solarized.toml
    fi
  '';
}
