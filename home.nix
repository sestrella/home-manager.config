{
  lib,
  pkgs,
  ...
}:

{
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Custom configuration
  imports = [
    ./home/bat
    ./home/fish
    ./home/ghostty
    ./home/git
    ./home/home-manager
    ./home/neovim
    ./home/nix
    ./home/ripgrep
    ./home/tmux
  ];

  # https://github.com/unpluggedcoder/awesome-rust-tools
  home.packages = [
    pkgs.asdf-vm
    pkgs.aws-vault
    pkgs.awscli2
    pkgs.bottom
    pkgs.btop
    pkgs.cachix
    pkgs.claude-code
    pkgs.coreutils
    pkgs.devenv
    pkgs.easyrsa
    pkgs.entr
    pkgs.fd
    pkgs.gitleaks
    pkgs.gnumake
    pkgs.iecs
    pkgs.jq
    pkgs.lazydocker
    pkgs.minikube
    pkgs.nerd-fonts.fira-code
    pkgs.noti
    pkgs.pstree
    pkgs.rename
    pkgs.ssm-session-manager-plugin
    pkgs.tmate
    pkgs.tree
    pkgs.watch
    pkgs.wget
    pkgs.yq
  ] ++ lib.optionals pkgs.stdenv.isDarwin [ pkgs.terminal-notifier ];

  home.sessionVariables.SHELL = "${pkgs.fish}/bin/fish";

  programs.direnv.enable = true;

  programs.fzf.enable = true;

  programs.gh = {
    enable = true;
    settings.git_protocol = "git";
  };

  programs.hmd.enable = true;

  programs.lsd = {
    enable = true;
    enableAliases = true;
    # https://github.com/lsd-rs/lsd#config-file-content
    settings.color.when = "never";
  };

  programs.starship.enable = true;

  programs.zoxide.enable = true;

  programs.lazygit.enable = true;
}
