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
      "rectangle"
      "session-manager-plugin"
      "slack"
      "spotify"
      "zoom"
    ];
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
}
