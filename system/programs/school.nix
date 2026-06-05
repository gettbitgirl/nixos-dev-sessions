{ pkgs, ... }:
{
  #environment.systemPackages = with pkgs; [ virt-manager ];
  #users.users.dev.extraGroups = [
  #  "docker"
  #];

  #virtualisation.docker.enable = true;
  #virtualisation.libvirtd.enable = true;
}
