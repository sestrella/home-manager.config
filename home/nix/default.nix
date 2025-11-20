{ ... }:

{
  config.xdg.configFile."nix/nix.conf".text = ''
    substituters = https://cache.nixos.org https://devenv.cachix.org https://nix-community.cachix.org https://nixpkgs-python.cachix.org https://nixpkgs-ruby.cachix.org https://nixpkgs-terraform.cachix.org https://sestrella.cachix.org https://stackbuilders.cachix.org
    trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs= nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU= nixpkgs-ruby.cachix.org-1:vrcdi50fTolOxWCZZkw0jakOnUI1T19oYJ+PRYdK4SM= nixpkgs-terraform.cachix.org-1:8Sit092rIdAVENA3ZVeH9hzSiqI/jng6JiCrQ1Dmusw= sestrella.cachix.org-1:uf75o4yckcsAOFu6ldfPug/kTUMybvT0IY61sck2qnA= stackbuilders.cachix.org-1:9uldaNPtrYr/fmY395PzoWSN2pdINOyTqP7UUHXHgn8=
  '';
}
