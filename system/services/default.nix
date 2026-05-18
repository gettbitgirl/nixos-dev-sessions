{
  services.flatpak.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  
  networking.firewall.allowedTCPPorts = [ 8384 ];
  services.syncthing = {
    dataDir = "/home/gettbit";
    enable = true;
    user = "gettbit";
    openDefaultPorts = true;
  };
}
