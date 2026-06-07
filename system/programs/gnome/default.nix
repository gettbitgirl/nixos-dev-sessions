{
  inputs,
  config,
  pkgs,
  ...
}: {
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  environment.systemPackages = with pkgs; [
    python315
    gnome-tweaks
    gnomeExtensions.appindicator
    inkscape
    inputs.yamis.packages.${pkgs.system}.default

    # Wayland wallpaper manager and GNOME extension
    waywallen
    waywallen-gnome
  ];
}
