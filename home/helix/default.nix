{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    extraPackages = [
      pkgs.golangci-lint-langserver
      pkgs.gopls
      pkgs.nil
      pkgs.terraform-ls
    ];
    settings = {
      theme = "solarized_dark";
    };
    languages = {
      language = [
        {
          name = "nix";
          formatter = {
            command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
          };
        }
      ];
    };
  };
}
