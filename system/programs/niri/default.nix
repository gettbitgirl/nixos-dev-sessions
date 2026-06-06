{
  inputs,
  config,
  pkgs,
  ...
}: {
  # Disable GNOME stack (it may be enabled by the base config)
  services.desktopManager.gnome.enable = false;
  services.displayManager.gdm.enable = false;

  # ── Compositor ────────────────────────────────────────────────────────────
  programs.niri.enable = true;

  # ── Display Manager: SDDM ─────────────────────────────────────────────────
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    # Theme ships with sddm-chili or use catppuccin; kept minimal here
    theme = "breeze";
  };

  # ── XDG Portals ───────────────────────────────────────────────────────────
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome # for GTK file pickers
    ];
    config.common.default = "gtk";
  };

  # ── Security / Auth ───────────────────────────────────────────────────────
  security.polkit.enable = true;

  # PAM entry so swaylock can auth
  security.pam.services.swaylock = {};

  # ── Session Services ──────────────────────────────────────────────────────
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # ── Keyboard layout (reuse existing xkb settings without xserver) ─────────
  services.xserver.enable = false;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # ── System Packages ───────────────────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    # icon set (kept from GNOME config)
    inputs.yamis.packages.${pkgs.system}.default

    # wallpaper
    waywallen
    swaybg

    # launcher
    rofi-wayland

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

    # audio
    pavucontrol

    # file manager
    nautilus

    # polkit agent (GTK)
    polkit_gnome

    # Wayland utilities
    wlr-randr
    wl-mirror
    grim
    slurp
    swappy # screenshot annotation

    # dbus / portals deps
    dconf
    gsettings-desktop-schemas
    glib
  ];
}
