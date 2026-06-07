{
  self,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./fonts.nix
    ./home-manager.nix
    # ./qt.nix
    ./stylix.nix
    self.modules.theme
  ];
  programs = {
    kdeconnect.enable = true;
  };
}
