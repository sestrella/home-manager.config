{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellInit = ''
      if test -e /opt/homebrew/bin/brew
        /opt/homebrew/bin/brew shellenv | source
      end

      . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    '';
  };
}
