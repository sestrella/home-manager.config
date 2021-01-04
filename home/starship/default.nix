{
  programs.starship = {
    enable = true;
    # config
    settings = {
      add_newline = false;
      character = {
        error_symbol = "[✗](bold red) ";
        success_symbol = "[➜](bold green) ";
      };
    };
  };
}
