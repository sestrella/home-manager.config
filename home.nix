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
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # Custom configuration
  imports = [
    ./home/bat
    ./home/fish
    ./home/ghostty
    ./home/git
    ./home/helix
    ./home/home-manager
    # TODO: remove this module
    # ./home/neovim
    ./home/nix
    ./home/ripgrep
    ./home/tmux
  ];

  # https://github.com/unpluggedcoder/awesome-rust-tools
  home.packages = [
    pkgs.asciinema
    pkgs.asciinema-agg
    pkgs.aws-vault
    pkgs.awscli2
    pkgs.bottom
    pkgs.cachix
    pkgs.claude-code
    pkgs.coreutils
    pkgs.devenv
    pkgs.dotenv-cli
    pkgs.easyrsa
    pkgs.entr
    pkgs.fd
    pkgs.gemini-cli
    pkgs.gitleaks
    pkgs.gnumake
    pkgs.gnused
    pkgs.iecs
    pkgs.jq
    pkgs.jujutsu
    pkgs.lazydocker
    pkgs.nerd-fonts.fira-code
    pkgs.noti
    pkgs.pstree
    pkgs.rename
    pkgs.ssm-session-manager-plugin
    pkgs.terminal-notifier
    pkgs.tmate
    pkgs.tree
    pkgs.watch
    pkgs.wget
    pkgs.yq
  ];

  home.sessionVariables.SHELL = lib.getExe pkgs.fish;

  programs.direnv.enable = true;

  programs.fzf.enable = true;

  programs.gh = {
    enable = true;
    settings.git_protocol = "git";
  };

  programs.hmd.enable = true;

  programs.lsd = {
    enable = true;
    enableFishIntegration = true;
    # https://github.com/lsd-rs/lsd#config-file-content
    settings.color.when = "never";
  };

  programs.starship.enable = true;

  programs.zoxide.enable = true;

  programs.lazygit.enable = true;
}
