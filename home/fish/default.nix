{ ... }:

{
  programs.fish = {
    enable = true;
    # functions.fish_greeting = "";
    loginShellInit = ''
      # fish_add_path /usr/local/bin
      # https://github.com/Homebrew/brew/blob/master/Library/Homebrew/cmd/shellenv.sh
      if test -x /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
      end

      . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    '';
  };
}
