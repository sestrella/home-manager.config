{ ... }:

{
  programs.fish = {
    enable = true;
    # functions.fish_greeting = "";
    loginShellInit = ''
      # fish_add_path /usr/local/bin
      # https://github.com/Homebrew/brew/blob/master/Library/Homebrew/cmd/shellenv.sh
      # eval (/opt/homebrew/bin/brew shellenv)
      . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    '';
  };
}
