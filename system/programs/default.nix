{ pkgs, ... }:
{
  imports = [
    ./fonts.nix
    ./home-manager.nix
    # ./qt.nix
    ./stylix.nix
    ./school.nix
  ];

  programs = {

    kdeconnect.enable = true;

  };


}
