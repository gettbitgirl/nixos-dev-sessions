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

    # file manager
    nautilus
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
}
