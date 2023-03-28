{ pkgs, ... }:

{
  homebrew = {
    enable = true;
    brews = [
      "dark-notify"
      "postgresql@14"
    ];
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
    onActivation.cleanup = "uninstall";
    taps = [
      "cormacrelf/tap"
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
      "homebrew/services"
    ];
  };

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = {
      substituters = [
        "https://cache.iog.io"
      ];
      trusted-public-keys = [
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      ];
    };
  };

  security.pam = {
    enableSudoTouchIdAuth = false;
    enablePamReattach = false;
  };

  services.nix-daemon.enable = true;

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  users.users.sestrella = {
    home = "/Users/sestrella";
    shell = pkgs.fish;
  };
}
