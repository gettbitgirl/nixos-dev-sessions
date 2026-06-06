{ ... }: {
  services.mako = {
    enable = true;
    settings = {
      # ── Layout ────────────────────────────────────────────────────────
      width = 360;
      height = 120;
      margin = 16;
      padding = "12,16";

      # ── Appearance ─────────────────────────────────────────────────────
      border-radius = 8;
      border-size = 2;

      # ── Behaviour ──────────────────────────────────────────────────────
      default-timeout = 5000;
      ignore-timeout = false;

      # ── Anchor ─────────────────────────────────────────────────────────
      anchor = "top-right";
      layer = "overlay";

      # ── Icons ───────────────────────────────────────────────────────────
      icons = true;
      max-icon-size = 48;

      # ── History ─────────────────────────────────────────────────────────
      max-history = 50;
    };
  };

  stylix.targets.mako.enable = true;
}
