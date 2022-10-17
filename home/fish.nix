{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellAbbrs = {
      # home-manager
      hmo = "home-manager option";
      hms = "home-manager switch --flake .#sestrella";
      # tmux - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/tmux
      ta = "tmux attach -t";
      tkss = "tmux kill-session -t";
      tksv = "tmux kill-server";
      tl = "tmux list-sessions";
      ts = "tmux new-session -s";
    };
    shellInit = ''
      if test -e /opt/homebrew/bin/brew
        /opt/homebrew/bin/brew shellenv | source
      end

      . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    '';
  };
}
