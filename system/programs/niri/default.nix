{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  # Disable GNOME stack (overrides the base config)
  services.desktopManager.gnome.enable = lib.mkForce false;
  services.displayManager.gdm.enable = lib.mkForce false;

  # ── Compositor ────────────────────────────────────────────────────────────
  programs.niri.enable = true;

  # ── Display Manager: SDDM ─────────────────────────────────────────────────
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    # No custom theme — use SDDM's built-in default (works without extra packages)
  };

  # ── XDG Portals ───────────────────────────────────────────────────────────
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk  # GTK file pickers, screenshots, etc.
    ];
    config.common.default = "gtk";
  };

  # ── Security / Auth ───────────────────────────────────────────────────────
  security.polkit.enable = true;

  # PAM entry so swaylock can authenticate
  security.pam.services.swaylock = {};

  # ── Session Services ──────────────────────────────────────────────────────
  programs.dconf.enable = true;
  services.gnome.gnome-keyring.enable = true;

  # ── System Packages ───────────────────────────────────────────────────────
  environment.systemPackages = with pkgs; [
    # icon set (kept from GNOME config)
    inputs.yamis.packages.${pkgs.system}.default

    # wallpaper
    waywallen
    swaybg

    # launcher (rofi-wayland merged into rofi in nixpkgs-unstable)
    rofi

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

    # polkit authentication agent (GTK)
    polkit_gnome

    # screenshot tools
    grim
    slurp
    swappy

    # Wayland output management
    wlr-randr

    # dbus / portals / GTK settings
    gsettings-desktop-schemas
    glib
  ];
}
