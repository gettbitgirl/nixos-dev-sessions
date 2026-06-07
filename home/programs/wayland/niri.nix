{
  pkgs,
  lib,
  ...
}: let
  nixos-rebuild-specialisation-exec = pkgs.writeShellScriptBin "nixos-rebuild-specialisation-exec" ''
    pkexec --user dev nixos-rebuild-specialisation
  '';
in {
  home.packages = [
    nixos-rebuild-specialisation-exec
  ];
  # Write niri's config as a KDL file.
  # Niri reads from $XDG_CONFIG_HOME/niri/config.kdl
  xdg.configFile."niri/config.kdl".text = ''
    // ── Environment Variables ─────────────────────────────────────────────
    environment {
      QT_QPA_PLATFORM "wayland"
      QT_WAYLAND_DISABLE_WINDOWDECORATION "1"
      MOZ_ENABLE_WAYLAND "1"
      GDK_BACKEND "wayland,x11"
      CLUTTER_BACKEND "wayland"
      SDL_VIDEODRIVER "wayland"
      NIXOS_OZONE_WL "1"
    }

    // ── Inputs ────────────────────────────────────────────────────────────
    input {
      keyboard {
        xkb {
          layout "us"
        }
        repeat-delay 300
        repeat-rate 50
      }

      touchpad {
        tap
        natural-scroll
        dwt  // disable while typing
        accel-speed 0.2
        click-method "clickfinger"
      }

      mouse {
        accel-speed 0.0
      }
    }

    // ── Output defaults ───────────────────────────────────────────────────
    // niri will auto-detect monitors; eDP-1 is the typical laptop panel name.
    output "eDP-1" {
      scale 1.0
      position x=0 y=0
    }

    // ── Layout ────────────────────────────────────────────────────────────
    layout {
      gaps 10
      center-focused-column "never"

      background-color "transparent"

      preset-column-widths {
        proportion 0.3333
        proportion 0.5000
        proportion 0.6667
      }

      default-column-width { proportion 0.5; }

      focus-ring {
        width 3
        active-color "#89b4fa"
        inactive-color "#45475a"
      }

      border {
        off
      }
    }

    // ── Animations ────────────────────────────────────────────────────────
    animations {
      slowdown 1.0
    }

    // ── Window rules ──────────────────────────────────────────────────────
    // (Note: niri opens dialogs/transient windows floating by default)

    window-rule {
      match app-id=r#"^org\.pulseaudio\.pavucontrol$"#
      open-floating true
      default-column-width { fixed 700; }
    }

    window-rule {
      match app-id=r#"^org\.gnome\.Nautilus$"#
      open-floating true
      default-column-width { fixed 900; }
    }

    window-rule {
      match app-id=r#"^kitty-quick-access$"#
      open-floating true
      default-column-width { fixed 1000; }
      default-window-height { fixed 600; }
    }

    window-rule {
      match app-id=r#"^nixos-rebuild$"#
      open-floating true
      default-column-width { fixed 1000; }
      default-window-height { fixed 600; }
    }

    layer-rule {
      match namespace=r#"^waywallen-wallpaper$"#
      place-within-backdrop true
    }

    layer-rule {
      match namespace=r#"^hamr$"#
      background-effect {
        blur true
        xray false
      }
    }

    blur {
      passes 3
      offset 3.0
      saturation 1.5
    }

    // ── Startup ───────────────────────────────────────────────────────────
    spawn-at-startup "waybar"
    spawn-at-startup "mako"
    spawn-at-startup "hamr"
    //spawn-at-startup "xwayland-satellite"
    spawn-at-startup "/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1"
    spawn-at-startup "sh" "-c" "wl-paste --watch cliphist store"
    spawn-at-startup "waywallen-layer-shell"
    spawn-at-startup "waywallen --no-ui"
    spawn-at-startup "sh" "-c" "swayidle -w timeout 300 'swaylock -f' timeout 600 'niri msg action power-off-monitors' before-sleep 'swaylock -f'"

    // ── Keybindings (Mod = Super) ─────────────────────────────────────────
    binds {
      // ── Applications ──
      Mod+Return { spawn "kitty"; }
      Mod+Space { spawn "hamr" "toggle"; }
      Mod+V { spawn "hamr" "plugin" "clipboard"; }
      Mod+E { spawn "nautilus"; }
      Mod+Shift+P { spawn "pavucontrol"; }

      // ── Screenshots ──
      Print { screenshot; }
      Mod+Print { screenshot-screen; }
      Mod+Shift+Print { screenshot-window; }

      // ── Help & System Rebuild ──
      Mod+Shift+Slash { show-hotkey-overlay; }
      Mod+Shift+B hotkey-overlay-title="Rebuild NixOS" { spawn "kitty" "--class" "nixos-rebuild" "-e" "nixos-rebuild-specialisation"; }

      // ── Overview & Quick Access ──

      F12 hotkey-overlay-title="Quick Access Terminal" { spawn "kitten" "quick-access-terminal"; }

      // ── Window Management ──
      Mod+Q { close-window; }
      Mod+F { maximize-column; }
      Mod+Shift+F { fullscreen-window; }
      Mod+C { center-column; }
      Mod+B { toggle-window-floating; }

      // ── Focus: vi-style ──
      Mod+H { focus-column-left; }
      Mod+J { focus-window-down; }
      Mod+K { focus-window-up; }
      Mod+L { focus-column-right; }
      Mod+Left { focus-column-left; }
      Mod+Down { focus-window-down; }
      Mod+Up { focus-window-up; }
      Mod+Right { focus-column-right; }

      // ── Move Windows ──
      Mod+Shift+H { move-column-left; }
      Mod+Shift+J { move-window-down; }
      Mod+Shift+K { move-window-up; }
      Mod+Shift+L { move-column-right; }
      Mod+Shift+Left { move-column-left; }
      Mod+Shift+Down { move-window-down; }
      Mod+Shift+Up { move-window-up; }
      Mod+Shift+Right { move-column-right; }

      // ── Column / Window Sizing ──
      Mod+Minus { set-column-width "-10%"; }
      Mod+Equal { set-column-width "+10%"; }
      Mod+Shift+Minus { set-window-height "-10%"; }
      Mod+Shift+Equal { set-window-height "+10%"; }
      Mod+R { switch-preset-column-width; }
      Mod+Shift+R { reset-window-height; }

      // ── Workspaces ──
      Mod+1 { focus-workspace 1; }
      Mod+2 { focus-workspace 2; }
      Mod+3 { focus-workspace 3; }
      Mod+4 { focus-workspace 4; }
      Mod+5 { focus-workspace 5; }
      Mod+6 { focus-workspace 6; }
      Mod+7 { focus-workspace 7; }
      Mod+8 { focus-workspace 8; }
      Mod+9 { focus-workspace 9; }
      Mod+Shift+1 { move-column-to-workspace 1; }
      Mod+Shift+2 { move-column-to-workspace 2; }
      Mod+Shift+3 { move-column-to-workspace 3; }
      Mod+Shift+4 { move-column-to-workspace 4; }
      Mod+Shift+5 { move-column-to-workspace 5; }
      Mod+Shift+6 { move-column-to-workspace 6; }
      Mod+Shift+7 { move-column-to-workspace 7; }
      Mod+Shift+8 { move-column-to-workspace 8; }
      Mod+Shift+9 { move-column-to-workspace 9; }

      Mod+Tab { focus-workspace-down; }
      Mod+Shift+Tab { focus-workspace-up; }

      // ── Monitor Focus ──
      Mod+Comma { focus-monitor-left; }
      Mod+Period { focus-monitor-right; }
      Mod+Shift+Comma { move-column-to-monitor-left; }
      Mod+Shift+Period { move-column-to-monitor-right; }

      // ── Session ──
      Mod+Alt+L { spawn "swaylock"; }
      Mod+Shift+E { quit; }

      // ── Media Keys ──
      XF86AudioRaiseVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
      XF86AudioLowerVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
      XF86AudioMute { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
      XF86AudioMicMute { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }
      XF86MonBrightnessUp { spawn "brightnessctl" "set" "+10%"; }
      XF86MonBrightnessDown { spawn "brightnessctl" "set" "10%-"; }
      XF86AudioPlay { spawn "playerctl" "play-pause"; }
      XF86AudioNext { spawn "playerctl" "next"; }
      XF86AudioPrev { spawn "playerctl" "previous"; }
    }
  '';

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
