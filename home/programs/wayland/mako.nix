{ ... }: {
  services.mako = {
    enable = true;
    settings = {
      # ── Layout ───────────────────────────────────────────────────
      width = 360;
      height = 120;
      margin = "16";
      padding = "12,16";

      # ── Appearance ────────────────────────────────────────────────
      border-radius = 8;
      border-size = 2;

      # ── Behaviour ─────────────────────────────────────────────────
      default-timeout = 5000; # ms
      ignore-timeout = false;

      # ── Anchor ────────────────────────────────────────────────────
      anchor = "top-right";
      layer = "overlay";

      # ── Icons ─────────────────────────────────────────────────────
      icons = true;
      max-icon-size = 48;

      # ── History ───────────────────────────────────────────────────
      max-history = 50;
    };
  };

  # Stylix themes mako automatically if the target is enabled
  stylix.targets.mako.enable = true;
}
