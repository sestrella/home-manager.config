{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      pkgs.golangci-lint-langserver
      pkgs.gopls
      pkgs.nil
      pkgs.terraform-ls
    ];
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
    settings = {
      theme = "solarized_dark";
    };
  };
}
