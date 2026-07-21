{ pkgs, ... }:

let
  helmWithPlugins = pkgs.wrapHelm pkgs.kubernetes-helm {
    plugins = [ pkgs.kubernetes-helmPlugins.helm-diff ];
  };
in
{
  home.packages = [
    helmWithPlugins
    pkgs.kubectl
  ];
}
