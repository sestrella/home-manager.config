{
  config,
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
      pkgs.golines
      pkgs.gopls
      pkgs.helix-gpt
      pkgs.marksman
      pkgs.nil
      pkgs.terraform-ls
      pkgs.yaml-language-server
    ];
    languages = {
      language-server.gpt = {
        command = "helix-gpt";
        args = ["--handler" "copilot"];
      };

      language = [
        {
          name = "go";
          language-servers = ["gopls" "golangci-lint-lsp" "gpt"];
        }
      ];
    };
    settings = {
      editor = {
        cursor-shape.insert = "bar";
        end-of-line-diagnostics = "hint";
        file-picker.hidden = false;
        inline-diagnostics.cursor-line = "warning";
        line-number = "relative";
      };
      theme = "solarized";
    };
  };

  launchd.agents.helix-theme = {
    enable = true;
    config = {
      ProgramArguments =
        let
          script = pkgs.writeScriptBin "helix-theme" ''
            mkdir -p ~/.config/helix/themes
            if [ "$1" == "dark" ]; then
              ln -sf ${config.programs.helix.package}/lib/runtime/themes/solarized_dark.toml ~/.config/helix/themes/solarized.toml
            else
              ln -sf ${config.programs.helix.package}/lib/runtime/themes/solarized_light.toml ~/.config/helix/themes/solarized.toml
            fi
          '';
        in
        [
          "/opt/homebrew/bin/dark-notify"
          "-c"
          "${script}/bin/helix-theme"
        ];
      RunAtLoad = true;
      KeepAlive = {
        Crashed = true;
        SuccessfulExit = false;
      };
    };
  };
}
