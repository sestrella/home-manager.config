{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "solarized_dark";
    };
    languages = {
      language-server = {
        golangci-lint-langserver = {
          command = "${pkgs.golangci-lint-langserver}/bin/golangci-lint-langserver";
        };
        gopls = {
          command = "${pkgs.gopls}/bin/gopls";
        };
        nil = {
          command = "${pkgs.nil}/bin/nil";
        };
        terraform-ls = {
          command = "${pkgs.terraform-ls}/bin/terraform-ls";
        };
      };

      language = [
        {
          name = "go";
          formatter = {
            command = "${pkgs.go}/bin/gofmt";
          };
        }
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
          };
        }
      ];
    };
  };
}
