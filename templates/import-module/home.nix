{ ... }:

{
  home.homeDirectory = "/Users/sestrella";
  home.username = "sestrella";

  programs.git.settings = {
    user = {
      email = "john.doe@acme.com";
      name = "John Doe";
    };
  };

  programs.opencode.settings = {
    disabled_providers = [ "opencode" ];
  };
}
