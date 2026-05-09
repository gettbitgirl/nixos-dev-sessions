{
  inputs,
  pkgs,
  self,
  lib,
  config,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.asus-fa506nc
    ./hardware-configuration.nix
    #./powersave.nix
  ];


  networking.hostName = "girlcomputer";

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [ "compress=zstd" "noatime" ];
    "/swap".options = [ "noatime" ];
  };

  swapDevices = [ { device = "/swap/swapfile"; } ];
}
