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
      pkgs.bash-language-server
      pkgs.docker-compose-language-service
      pkgs.elixir-ls
      pkgs.nixd
      pkgs.nixfmt
      pkgs.terraform-ls
      pkgs.vscode-json-languageserver
      pkgs.yaml-language-server
    ];
    languages = {
      language = [
        {
          name = "elixir";
          auto-format = true;
        }
        {
          name = "markdown";
          soft-wrap.enable = true;
        }
        {
          name = "nix";
          auto-format = true;
        }
      ];
    };
    settings = {
      editor = {
        cursor-shape.insert = "bar";
        file-picker.hidden = false;
        line-number = "relative";
        mouse = false;
        rulers = [ 80 ];
      };
      theme = "solarized";
    };
  };

  services.helix-theme-sync = {
    enable = true;

    configDir = "${config.home.homeDirectory}/.config/helix";
    runtimeDir = "${pkgs.helix-unwrapped.HELIX_DEFAULT_RUNTIME}";
    theme = config.programs.helix.settings.theme;
  };
}
