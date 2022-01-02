{ pkgs, ... }:

let
  yamlFormat = pkgs.formats.yaml {};
in {
  home.file.".stack/config.yaml".source = yamlFormat.generate "stack-config" {
    templates = {
      params = {
        author-email = "sestrella.me@gmail.com";
        author-name = "Sebastian Estrella";
        github-username = "sestrella";
        year = 2022;
      };
    };
  };
}
