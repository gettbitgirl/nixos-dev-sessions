{ ... }: {
  programs.swaylock = {
    enable = true;
    # Appearance is fully managed by Stylix (colors, wallpaper, etc.)
    # We only set behaviour options here.
    settings = {
      show-failed-attempts = true;
      daemonize = true;
      indicator-radius = 80;
      indicator-thickness = 10;
      clock = false;
      scaling = "fill";
    };
  };

  stylix.targets.swaylock.enable = true;
}
