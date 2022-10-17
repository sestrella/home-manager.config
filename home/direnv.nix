{ config, pkgs, ... }:

{
  programs.direnv.enable = true;

  xdg.configFile."direnv/lib/use_flake.sh".text = ''
    use_flake() {
      watch_file flake.nix
      watch_file flake.lock
      eval "$(nix print-dev-env --profile "$(direnv_layout_dir)/flake-profile")"
    }
  '';
}
