{
  pkgs,
  lib,
  ...
}: {
  programs.kitty.enable = true;
  programs.kitty.extraConfig = ''
    background_opacity 0.8
    auto_reload_config -1
  '';
  stylix.targets.kitty.enable = true;
}
