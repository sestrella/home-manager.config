{ pkgs, ... }:

{
  environment = {
    shells = [
      pkgs.fish
    ];
    systemPackages = [
      pkgs.pam-reattach
    ];
  };

  homebrew = {
    enable = true;
    brews = [
      "dark-notify"
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
    ];
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  security.pam.enableSudoTouchIdAuth = false;

  services.nix-daemon.enable = true;

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  programs.fish.enable = true;

  users.users.sestrella = {
    home = "/Users/sestrella";
    shell = pkgs.fish;
  };
}
