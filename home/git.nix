{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push = {
        autoSetupRemote = true;
        default = "simple";
      };
      rerere.enabled = true;
    };
    delta = {
      enable = true;
      # https://github.com/dandavison/delta/issues/447
      package = pkgs.writeScriptBin "delta" ''
        if defaults read -g AppleInterfaceStyle &> /dev/null; then
          ${pkgs.delta}/bin/delta "$@"
        else
          ${pkgs.delta}/bin/delta --light "$@"
        fi
      '';
      options.line-numbers = true;
    };
    userEmail = "2049686+sestrella@users.noreply.github.com";
    userName = "Sebastian Estrella";
  };

  programs.fish.shellAbbrs = {
    "gc!" = "git commit -v --amend";
    "gp!" = "git push --force-with-lease";
    ga = "git add";
    gaa = "git add --all";
    gbr = "git branch --remote";
    gc = "git commit -v";
    gco = "git checkout";
    gd = "git diff";
    gl = "git pull";
    gp = "git push";
    gst = "git status";
  };
}
