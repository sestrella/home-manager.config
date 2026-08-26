{ pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
  };

  home.username = "runner";

  home.packages = [ pkgs.terraform ];

  programs.git.settings = {
    user.email = "john.doe@acme.com";
  };

  programs.opencode.settings = {
    disabled_providers = [ "opencode" ];
  };
}
