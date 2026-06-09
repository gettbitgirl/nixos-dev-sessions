{
  inputs,
  pkgs,
  ...
}: let
  #skwd-patched = inputs.skwd.packages.${pkgs.system}.default.overrideAttrs (oldAttrs: {
  #  preFixup =
  #    (oldAttrs.preFixup or "")
  #    + ''
  #      mkdir -p $out/share/skwd
  #      cp -a ${inputs.skwd.inputs.skwd-daemon.packages.${pkgs.system}.default}/share/skwd/skwd-daemon $out/share/skwd/
  #      cp ${./AppCacheService.qml} $out/share/skwd/skwd-launch/qml/services/AppCacheService.qml
  #    '';
  #});
in {
  imports = [
    inputs.skwd-wall.nixosModules.default
  ];
  #inputs.skwd-wall.packages.${pkgs.system}.default
  programs.skwd-wall.enable = true;

  #environment.sessionVariables = {
  #  SKWD_INSTALL = "${skwd-patched}/share/skwd";
  #};

  # ── Compositor ────────────────────────────────────────────────────────────
  programs.niri.enable = true;

  environment.etc."xdg/menus/applications.menu".source = ./dolphin.menu;

  # ── Display Manager: SDDM ─────────────────────────────────────────────────
  services.displayManager.sddm = {
    enable = true;
    # Enable the Wayland backend
    wayland.enable = true;

    # Optional: auto-login (uncomment and set user to auto-login on boot)
    # autoLogin.enable = true;
    # autoLogin.user = "dev";
  };

  # ── XDG Portals ───────────────────────────────────────────────────────────
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk # GTK file pickers, screenshots, etc.
      kdePackages.xdg-desktop-portal-kde
    ];
    config.common.default = "kde";
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
    # file manager
    kdePackages.dolphin
    kdePackages.systemsettings
    ffmpegthumbnailer
    kdePackages.ffmpegthumbs
    kdePackages.plasma-workspace
    kdePackages.kservice

    #skwd-patched
    noctalia-shell
    xwayland-satellite
    cava

    #shell
    waywallen
    waywallen-layer-shell

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
