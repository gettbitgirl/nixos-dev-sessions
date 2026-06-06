{
  config,
  pkgs,
  ...
}: {
  programs.niri = {
    enable = true;

    settings = {
      # ── Environment Variables ────────────────────────────────────────────
      environment = {
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        MOZ_ENABLE_WAYLAND = "1";
        GDK_BACKEND = "wayland,x11";
        CLUTTER_BACKEND = "wayland";
        SDL_VIDEODRIVER = "wayland";
        # Needed for some electron apps
        NIXOS_OZONE_WL = "1";
      };

      # ── Inputs ───────────────────────────────────────────────────────────
      input = {
        keyboard = {
          xkb.layout = "us";
          repeat-delay = 300;
          repeat-rate = 50;
        };
        touchpad = {
          tap = true;
          natural-scroll = true;
          dwt = true; # disable while typing
          accel-speed = 0.2;
          click-method = "clickfinger";
        };
        mouse = {
          natural-scroll = false;
          accel-speed = 0.0;
        };
      };

      # ── Outputs (sensible defaults, niri auto-detects monitors) ──────────
      outputs."eDP-1" = {
        scale = 1.0;
        position = { x = 0; y = 0; };
      };

      # ── Layout ───────────────────────────────────────────────────────────
      layout = {
        gaps = 10;
        center-focused-column = "never";

        preset-column-widths = [
          { proportion = 1.0 / 3.0; }
          { proportion = 1.0 / 2.0; }
          { proportion = 2.0 / 3.0; }
        ];

        default-column-width = { proportion = 1.0 / 2.0; };

        focus-ring = {
          enable = true;
          width = 3;
          active.color = "#89b4fa";   # catppuccin blue-ish, overridden by stylix
          inactive.color = "#45475a";
        };

        border = {
          enable = false; # focus-ring is enough
          width = 2;
          active.color = "#89b4fa";
          inactive.color = "#313244";
        };
      };

      # ── Animations ───────────────────────────────────────────────────────
      animations = {
        slowdown = 1.0;
      };

      # ── Window Rules ─────────────────────────────────────────────────────
      window-rules = [
        # Float common dialogs
        {
          matches = [{ is-dialog = true; }];
          open-floating = true;
        }
        # Pavucontrol floats
        {
          matches = [{ app-id = "^org\\.pulseaudio\\.pavucontrol$"; }];
          open-floating = true;
          default-column-width = { fixed = 700; };
        }
        # Nautilus floats at a comfortable size
        {
          matches = [{ app-id = "^org\\.gnome\\.Nautilus$"; }];
          open-floating = true;
          default-column-width = { fixed = 900; };
        }
      ];

      # ── Keybindings (Mod = Super) ─────────────────────────────────────────
      binds = with config.lib.niri.actions; {
        # ── Applications ──
        "Mod+Return".action = spawn "kitty";
        "Mod+Space".action = spawn "rofi" "-show" "drun";
        "Mod+Shift+Space".action = spawn "rofi" "-show" "run";
        "Mod+E".action = spawn "nautilus";
        "Mod+Shift+P".action = spawn "pavucontrol";

        # Screenshots
        "Print".action = screenshot;
        "Mod+Print".action = screenshot-screen;
        "Mod+Shift+Print".action = screenshot-window;

        # ── Window Management ──
        "Mod+Q".action = close-window;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+C".action = center-column;
        "Mod+V".action = toggle-window-floating;

        # ── Focus: vi-style + arrows ──
        "Mod+h".action = focus-column-left;
        "Mod+j".action = focus-window-down;
        "Mod+k".action = focus-window-up;
        "Mod+l".action = focus-column-right;
        "Mod+Left".action = focus-column-left;
        "Mod+Down".action = focus-window-down;
        "Mod+Up".action = focus-window-up;
        "Mod+Right".action = focus-column-right;

        # ── Move Windows ──
        "Mod+Shift+h".action = move-column-left;
        "Mod+Shift+j".action = move-window-down;
        "Mod+Shift+k".action = move-window-up;
        "Mod+Shift+l".action = move-column-right;
        "Mod+Shift+Left".action = move-column-left;
        "Mod+Shift+Down".action = move-window-down;
        "Mod+Shift+Up".action = move-window-up;
        "Mod+Shift+Right".action = move-column-right;

        # ── Column Sizing ──
        "Mod+minus".action = set-column-width "-10%";
        "Mod+equal".action = set-column-width "+10%";
        "Mod+Shift+minus".action = set-window-height "-10%";
        "Mod+Shift+equal".action = set-window-height "+10%";
        "Mod+r".action = switch-preset-column-width;
        "Mod+Shift+r".action = reset-window-height;

        # ── Workspaces ──
        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;
        "Mod+8".action = focus-workspace 8;
        "Mod+9".action = focus-workspace 9;
        "Mod+Shift+1".action = move-column-to-workspace 1;
        "Mod+Shift+2".action = move-column-to-workspace 2;
        "Mod+Shift+3".action = move-column-to-workspace 3;
        "Mod+Shift+4".action = move-column-to-workspace 4;
        "Mod+Shift+5".action = move-column-to-workspace 5;
        "Mod+Shift+6".action = move-column-to-workspace 6;
        "Mod+Shift+7".action = move-column-to-workspace 7;
        "Mod+Shift+8".action = move-column-to-workspace 8;
        "Mod+Shift+9".action = move-column-to-workspace 9;

        "Mod+Tab".action = focus-workspace-down;
        "Mod+Shift+Tab".action = focus-workspace-up;

        # ── Monitor Focus ──
        "Mod+comma".action = focus-monitor-left;
        "Mod+period".action = focus-monitor-right;
        "Mod+Shift+comma".action = move-column-to-monitor-left;
        "Mod+Shift+period".action = move-column-to-monitor-right;

        # ── Session ──
        "Mod+l".action = spawn "swaylock";
        "Mod+Shift+e".action = quit;

        # ── Media Keys ──
        "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+";
        "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-";
        "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
        "XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
        "XF86MonBrightnessUp".action = spawn "brightnessctl" "set" "+10%";
        "XF86MonBrightnessDown".action = spawn "brightnessctl" "set" "10%-";
        "XF86AudioPlay".action = spawn "playerctl" "play-pause";
        "XF86AudioNext".action = spawn "playerctl" "next";
        "XF86AudioPrev".action = spawn "playerctl" "previous";
      };

      # ── Startup ──────────────────────────────────────────────────────────
      spawn-at-startup = [
        # Waybar status bar
        { command = [ "waybar" ]; }
        # Notification daemon
        { command = [ "mako" ]; }
        # Polkit authentication agent
        { command = [ "/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1" ]; }
        # Clipboard history (writes to cliphist)
        { command = [ "sh" "-c" "wl-paste --watch cliphist store" ]; }
        # Wallpaper via waywallen
        { command = [ "sh" "-c" "waywallen set" ]; }
        # Swayidle for auto-lock
        {
          command = [
            "swayidle" "-w"
            "timeout" "300" "swaylock -f"
            "timeout" "600" "niri msg action power-off-monitors"
            "before-sleep" "swaylock -f"
          ];
        }
      ];
    };
  };
}
