{ pkgs }:

# TODO: Install dark-notify executable via nix (remove from brew)
let
  darkNotify = pkgs.vimUtils.buildVimPlugin {
    name = "dark-notify";
    src = pkgs.fetchFromGitHub {
      owner = "cormacrelf";
      repo = "dark-notify";
      rev = "891adc07dd7b367b840f1e9875b075fd8af4dc52";
      sha256 = "i90NsosFcRd6V2lPjJIG+R0KXwBtWj8L1J0JCJakmvs=";
    };
  };
in
{
  plugin = darkNotify;
  config = builtins.readFile ./dark-notify.lua;
  type = "lua";
}
