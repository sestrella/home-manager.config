{ ... }:

{
  home = {
    homeDirectory = "/Users/runner";
    username = "runner";
  };

  programs.git.settings = {
    user.email = "john.doe@acme.com";
  };

  programs.opencode.settings = {
    disabled_providers = [ "opencode" ];
  };
}
