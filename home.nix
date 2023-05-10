{ config, pkgs, ... }:

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
  home.packages =
    let
      aws-gate = pkgs.python3Packages.buildPythonApplication rec {
        pname = "aws-gate";
        version = "0.11.2";
        src = pkgs.python3Packages.fetchPypi {
          inherit pname version;
          sha256 = "sha256-JOs+RZDI9aBAEvBZh40u1a5eOvnW6LSks/xsP46uRos=";
        };
        propagatedBuildInputs = [
          pkgs.python3Packages.boto3
          pkgs.python3Packages.requests
          pkgs.python3Packages.stdenv
          pkgs.python3Packages.wrapt
          pkgs.python3Packages.pyyaml
          pkgs.python3Packages.marshmallow
        ];
      };
    in
    [
      aws-gate
      pkgs.aws-vault
      pkgs.awscli2
      pkgs.circleci-cli
      pkgs.jq
      pkgs.tmate
      pkgs.tree
      pkgs.wget
    ];

  programs.autojump.enable = true;

  programs.bottom.enable = true;

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
    shellAbbrs.top = "btm";
  };

  programs.starship.enable = true;
}
