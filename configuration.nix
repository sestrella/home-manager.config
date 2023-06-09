{ pkgs, ... }:

{
  environment.shells = [
    pkgs.fish
  ];

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
      "obsidian"
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

  services.nix-daemon.enable = true;

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  programs.fish = {
    enable = true;
    shellInit = ''
      if test -x /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
      end
    '';
  };

  users.users.sestrella = {
    home = "/Users/sestrella";
    shell = pkgs.fish;
  };
}
