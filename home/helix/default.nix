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

  # TODO: Test this approach
  launchd.agents.sync-helix-theme = {
    enable = true;
    config = {
      ProgramArguments =
        let
          script = pkgs.writeScript "sync-helix-theme" ''
            mkdir =p ~/.config/helix/themes
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
          "${script}/bin/sync-helix-theme"
        ];
      RunAtLoad = true;
      KeepAlive = {
        Crashed = true;
        SuccessfulExit = false;
      };
    };
  };
}
