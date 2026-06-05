{
  services.flatpak.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  
  networking.firewall.allowedTCPPorts = [ 8384 ];
  services.syncthing = {
    dataDir = "/home/dev";
    enable = true;
    user = "dev";
    openDefaultPorts = true;
  };
}
