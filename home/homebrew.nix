{ ... }:

{
  home.file.".Brewfile" = {
    text = ''
      cask "ghostty"
    '';
    onChange = "/opt/homebrew/bin/brew bundle install --global --force";
  };
}
