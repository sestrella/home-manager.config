{ auto-dark-mode, config, pkgs, ... }:

{
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Custom configuration
  imports = [
    ./home/bat.nix
    ./home/git.nix
    ./home/neovim.nix
    ./home/ripgrep.nix
    ./home/tmux.nix
  ];

  # https://github.com/unpluggedcoder/awesome-rust-tools
  home.packages = [
    pkgs.aws-vault
    pkgs.awscli2
    pkgs.btop
    pkgs.circleci-cli
    pkgs.jq
    pkgs.nix-prefetch-git
    pkgs.pstree
    pkgs.tmate
    pkgs.tree
    pkgs.watch
    pkgs.wget
  ];

  programs.autojump.enable = true;

  programs.direnv.enable = true;

  programs.fzf.enable = true;

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "git";
    };
  };

  programs.lsd = {
    enable = true;
    enableAliases = true;
    # https://github.com/lsd-rs/lsd#config-file-content
    settings.color.when = "never";
  };

  programs.fish = {
    enable = true;
    functions.fish_greeting = "";
    shellAbbrs.nfid = ''
      nix flake init --template github:cachix/devenv#flake-parts
    '';
  };

  programs.starship.enable = true;

  nixpkgs.overlays = [
    (final: prev: {
      vimPlugins = prev.vimPlugins.extend (final': prev': {
        auto-dark-mode-nvim = pkgs.vimUtils.buildVimPlugin {
          name = "auto-dark-mode.nvim";
          src = auto-dark-mode;
        };
      });
    })
  ];
}
