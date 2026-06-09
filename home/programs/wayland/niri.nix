{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # icon set (kept from GNOME config)
    inputs.yamis.packages.${pkgs.system}.default

    # wallpaper

    swaybg

    # launcher (rofi-wayland merged into rofi in nixpkgs-unstable)
    rofi

    # config
    nirimod

    # notifications
    mako
    libnotify

    # screen lock / idle
    swaylock
    swayidle

    # clipboard
    wl-clipboard
    cliphist

    # hardware controls
    brightnessctl
    playerctl

    # audio mixer GUI
    pavucontrol

    # steam
    steamcmd
  ];

  services.linux-wallpaperengine = {
    enable = true;
    assetsPath = "/home/dev/.local/share/Steam/steamapps/common/wallpaper_engine/assets";
  };

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 0;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 0;
    };
  };

  stylix.targets.noctalia-shell.enable = true;
}
