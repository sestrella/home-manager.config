{
  config,
  lib,
  pkgs,
  ...
}:

let
  helixThemeSync = pkgs.writeShellApplication {
    name = "helix-theme-sync";
    text = builtins.readFile ./helix-theme-sync.bash;
  };
in
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
      pkgs.shellcheck
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

  # This has already been implemented in the master branch.
  xdg.configFile."helix/config.toml".onChange = "/usr/bin/pkill -USR1 hx || true";

  launchd.agents.helix-theme-sync = {
    enable = true;

    config = {
      Program = lib.getExe helixThemeSync;
      ProgramArguments = [
        "${pkgs.helix-unwrapped.HELIX_DEFAULT_RUNTIME}/themes"
        "${config.programs.helix.settings.theme}"
      ];
      ProcessType = "Background";
      RunAtLoad = true;
      KeepAlive = {
        Crashed = true;
        SuccessfulExit = false;
      };
      StandardOutPath = "${config.home.homeDirectory}/.local/state/helix-theme-sync/logs/out.log";
      StandardErrorPath = "${config.home.homeDirectory}/.local/state/helix-theme-sync/logs/err.log";
    };
  };
}
