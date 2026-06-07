{
  inputs,
  pkgs,
  lib,
  ...
}: let
  nixos-rebuild-specialisation = pkgs.writeShellScriptBin "nixos-rebuild-specialisation" ''
    set -euo pipefail
    cd /home/dev/Dev/nixos-dev-sessions
    echo "Rebuilding NixOS in specialization: niri"
    nixos-rebuild switch --flake .#girlcomputer --specialisation niri
    echo "Finished! Press Enter to close."
    read -r
  '';
  nixos-rebuild-polkit = pkgs.writeTextFile {
    name = "nixos-rebuild-polkit";
    destination = "/share/polkit-1/actions/org.gettbitgirl.nixosrebuild.policy";
    text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE policyconfig PUBLIC
        "-//freedesktop//DTD PolicyKit Policy Configuration 1.0//EN"
        "http://freedesktop.org">
      <policyconfig>
        <action id="com.gettbitgirl.nixos-rebuild.run">
          <description>Rebuild NixOS configuration</description>
          <message>Authentication is required to rebuild NixOS configuration</message>
          <defaults>
            <allow_any>auth_admin</allow_any>
            <allow_inactive>auth_admin</allow_inactive>
            <allow_active>auth_admin</allow_active>
          </defaults>
          <annotate key="org.freedesktop.policykit.exec.path">${nixos-rebuild-specialisation}/bin/nixos-rebuild-specialisation</annotate>
        </action>
      </policyconfig>
    '';
  };
in {
  # Keep GNOME stack enabled so GDM can launch its greeter session
  services.desktopManager.gnome.enable = lib.mkForce true;
  services.displayManager.gdm.enable = lib.mkForce true;
  services.displayManager.defaultSession = "niri";

  # ── Compositor ────────────────────────────────────────────────────────────
  programs.niri.enable = true;

  # ── Display Manager: SDDM ─────────────────────────────────────────────────
  services.displayManager.sddm = {
    enable = false;
  };

  # ── XDG Portals ───────────────────────────────────────────────────────────
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk # GTK file pickers, screenshots, etc.
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
    xwayland-satellite

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
