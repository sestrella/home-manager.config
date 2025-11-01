{ pkgs, ... }:

{
  home.packages = [
    pkgs.git-filter-repo
  ];

  programs.git = {
    enable = true;
    settings.user = {
      email = "2049686+sestrella@users.noreply.github.com";
      name = "Sebastian Estrella";
      init.defaultBranch = "main";
      pull.rebase = true;
      push = {
        autoSetupRemote = true;
        default = "simple";
      };
      rerere.enabled = true;
    };
  };

  programs.delta = {
    enable = true;
    options.line-numbers = true;
    enableGitIntegration = true;
  };

  programs.fish.shellAbbrs = {
    "gc!" = "git commit -v --amend";
    "gd!" = "git diff --cached";
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
