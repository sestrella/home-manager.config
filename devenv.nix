{
  config,
  pkgs,
  lib,
  ...
}:

{
  env.GEMINI_API_KEY = config.secretspec.secrets.GEMINI_API_KEY or "";

  git-hooks.hooks = {
    auto-commit-msg = {
      enable = true;
      entry = lib.getExe pkgs.auto-commit-msg;
      stages = [ "prepare-commit-msg" ];
    };
    gitleaks.enable = true;
  };
}
