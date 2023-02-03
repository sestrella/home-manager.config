{ pkgs, ... }:

{
  users.users.sestrella = {
    home = "/Users/sestrella";
    shell = pkgs.fish;
  };

  services.nix-daemon.enable = true;

  homebrew = {
    enable = true;
    casks = [
      "1password"
      "docker"
      "font-fira-code-nerd-font"
      "google-chrome"
      "grammarly-desktop"
      "iterm2-beta"
      "notion"
      "rectangle"
      "session-manager-plugin"
      "slack"
      "spotify"
      "zoom"
    ];
  };

  nix.settings = {
    substituters = [
      "https://cache.iog.io"
    ];
    trusted-public-keys = [
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    ];
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
}
