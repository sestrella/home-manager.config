{ pkgs, ... }:

{
  home.packages = [
    pkgs.nix-index
    pkgs.nix-prefetch
    pkgs.nixpkgs-fmt
  ];

  nix.package = pkgs.nix;
  nix.settings =
    let
      caches = {
        "cache.nixos.org" = "6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
        "nixpkgs-python.cachix.org" = "hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU=";
        "nixpkgs-ruby.cachix.org" = "vrcdi50fTolOxWCZZkw0jakOnUI1T19oYJ+PRYdK4SM=";
        "nixpkgs-terraform.cachix.org" = "8Sit092rIdAVENA3ZVeH9hzSiqI/jng6JiCrQ1Dmusw=";
        "sestrella.cachix.org" = "uf75o4yckcsAOFu6ldfPug/kTUMybvT0IY61sck2qnA=";
        "stackbuilders.cachix.org" = "9uldaNPtrYr/fmY395PzoWSN2pdINOyTqP7UUHXHgn8=";
      };
    in
    {
      netrc-file = "/Users/sestrella/.config/nix/netrc";
      substituters = builtins.map (domain: "https://${domain}") (builtins.attrNames caches);
      trusted-public-keys = builtins.attrValues (builtins.mapAttrs (domain: key: "${domain}-1:${key}") caches);
    };
}
