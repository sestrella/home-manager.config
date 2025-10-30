{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = [
      pkgs.bash-language-server
      pkgs.docker-compose-language-service
      pkgs.gopls
      pkgs.nixd
      pkgs.nixfmt-rfc-style
      pkgs.terraform-ls
      pkgs.yaml-language-server
      pkgs.elixir-ls
    ];
    languages = {
      language = [
        {
          name = "elixir";
          auto-format = true;
        }
        {
          name = "go";
          auto-format = true;
        }
        {
          name = "nix";
          formatter = {
            command = "nixfmt";
          };
          auto-format = true;
        }
        {
          name = "rust";
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
      theme = "solarized_dark";
    };
  };
}
