{ ... }:

{
  programs.fish = {
    enable = true;
    loginShellInit = ''
      # fish_add_path /usr/local/bin
      # https://github.com/Homebrew/brew/blob/master/Library/Homebrew/cmd/shellenv.sh
      if test -x /opt/homebrew/bin/brew
        eval (/opt/homebrew/bin/brew shellenv)
      end

      . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    '';
    shellAbbrs = {
      # terraform
      tf = "terraform";
      tfa = "terraform apply";
      tfp = "terraform plan";
      # zellij
      za = "zellij attach";
      zk = "zellij kill-session";
      zls = "zellij list-sessions";
    };
  };
}
