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
    ./school.nix
    self.modules.theme
  ];
  programs = {
    kdeconnect.enable = true;
  };
  programs.virt-manager.enable = true;

  programs.ssh.extraConfig = ''
    Host vm 192.168.122.45
      HostName 192.168.122.45
      User vm
      IdentityFile ~/.ssh/vm
      IdentitiesOnly yes
  '';

  users.groups.libvirtd.members = ["dev"];

  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [virtiofsd];
  };

  virtualisation.spiceUSBRedirection.enable = true;
}
