{
  programs.git = {
    enable = true;
    # config
    extraConfig = {
      pull.rebase = false;
      push.default = "current";
    };
    userEmail = "2049686+sestrella@users.noreply.github.com";
    userName = "Sebastián Estrella";
    signing = {
      key = "AE40EFE7A18891F5";
      signByDefault = true;
    };
  };
}
