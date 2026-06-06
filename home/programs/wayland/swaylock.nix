{ config, ... }: {
  programs.swaylock = {
    enable = true;
    settings = {
      # Use the system wallpaper as the lock background
      image = "${config.stylix.image}";

      # Appearance
      scaling = "fill";
      show-failed-attempts = true;
      daemonize = true;

      # Indicator style — colors come from stylix if the target is enabled,
      # but we provide legible fallbacks here.
      indicator-radius = 80;
      indicator-thickness = 10;

      # Disable clock (keep it minimal)
      clock = false;
    };
  };

  stylix.targets.swaylock.enable = true;

  # ── Swayidle: auto-lock + monitor power-off ─────────────────────────────
  # Launched from niri's spawn-at-startup instead of a systemd service so it
  # can use niri's IPC to power off monitors.  If you prefer systemd, set
  # `services.swayidle.enable = true` here instead.
}
