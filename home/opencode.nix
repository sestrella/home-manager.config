{ ... }:

{
  programs.opencode = {
    enable = true;

    settings = {
      autoupdate = false;
      permission = {
        "*" = "allow";
        "bash" = {
          "*" = "allow";
          "rm *" = "ask";
        };
      };
    };
    tui.theme = "system";
  };
}
