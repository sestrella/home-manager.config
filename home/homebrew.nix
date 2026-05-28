{ ... }:

{
  home.file.".Brewfile" = {
    text = ''
      cask "ghostty"
      cask "google-chrome"
      cask "spotify"
    '';
    onChange = "/opt/homebrew/bin/brew bundle install --global --cleanup --force";
  };
}
