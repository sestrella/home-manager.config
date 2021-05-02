{
  # https://nixos.wiki/wiki/Nix_Cookbook
  home.file.".xprofile".text = ''
    export XDG_DATA_DIRS=$HOME/.nix-profile/share:/usr/local/share:/usr/share
  '';
}
