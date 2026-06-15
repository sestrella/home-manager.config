{ ... }:

{
  home.file.".Brewfile" = {
    text = ''
      cask "1password"
      cask "ghostty"
    '';
    onChange = "/opt/homebrew/bin/brew bundle install --global --force";
  };
}
