{ pkgs, lib, ... }:

{
  dotenv.enable = true;

  git-hooks.hooks.prepare-commit-msg = {
    enable = true;
    entry = lib.getExe pkgs.autocommitmsg;
    stages = [ "prepare-commit-msg" ];
  };
}
