{ ... }:

{
  programs.fish = {
    enable = true;

    loginShellInit = ''
      # https://github.com/Homebrew/brew/blob/master/Library/Homebrew/cmd/shellenv.sh
      if test -x /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
      end

      . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    '';
    interactiveShellInit = ''
      set -U fish_greeting
    '';
    shellAbbrs = {
      tf = "terraform";
      tfa = "terraform apply";
      tfp = "terraform plan";
    };
  };
}
