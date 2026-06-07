{...}: {
  programs.waybar = {
    enable = true;
    systemd.enable = false; # we launch it from niri spawn-at-startup

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 34;
        spacing = 4;

        modules-left = [
          "niri/workspaces"
          "niri/window"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "pulseaudio"
          "network"
          "battery"
          "memory"
          "cpu"
          "tray"
        ];

        # ── Module configs ──────────────────────────────────────────────
        "niri/workspaces" = {
          format = "{index}";
          on-click = "activate";
        };

        "niri/window" = {
          max-length = 60;
          separate-outputs = true;
        };

        clock = {
          format = " {:%H:%M}";
          format-alt = " {:%A, %B %d %Y  %H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-icons = ["" "" "" "" ""];
        };

        network = {
          format-wifi = " {signalStrength}%";
          format-ethernet = " {ipaddr}";
          format-linked = " {ifname} (No IP)";
          format-disconnected = "⚠ Disconnected";
          tooltip-format = "{essid} — {signalStrength}%\n{ipaddr}/{cidr} via {gwaddr}";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = " muted";
          format-icons = {
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
          scroll-step = 5;
        };

        memory = {
          format = " {used:0.1f}G";
          tooltip-format = "{used:0.1f}G / {total:0.1f}G used";
          interval = 5;
        };

        cpu = {
          format = " {usage}%";
          tooltip = true;
          interval = 5;
        };

        tray = {
          spacing = 10;
          icon-size = 18;
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "Inter", "ComicShannsMono Nerd Font Mono", sans-serif;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background-color: alpha(@base00, 0.92);
        border-bottom: 2px solid alpha(@base03, 0.5);
        color: @base05;
        transition: background-color 0.3s ease;
      }

      #workspaces button {
        padding: 0 6px;
        background-color: transparent;
        color: @base04;
        border-radius: 4px;
        margin: 4px 2px;
      }

      #workspaces button.active {
        background-color: @base02;
        color: @base07;
        border-radius: 4px;
      }

      #workspaces button:hover {
        background: alpha(@base03, 0.5);
        border-radius: 4px;
      }

      #clock {
        padding: 0 12px;
        color: @base05;
        font-weight: 600;
      }

      #battery,
      #cpu,
      #memory,
      #network,
      #pulseaudio,
      #tray {
        padding: 0 10px;
        color: @base05;
      }

      #battery.warning {
        color: @base09;
      }

      #battery.critical {
        color: @base08;
        animation: blink 0.5s linear infinite alternate;
      }

      @keyframes blink {
        to { color: @base00; background-color: @base08; }
      }

      #tray {
        padding: 0 8px;
      }

      #tray > .passive { -gtk-icon-effect: dim; }
      #tray > .needs-attention { -gtk-icon-effect: highlight; }

      #window {
        padding: 0 8px;
        color: @base04;
        font-style: italic;
      }
    '';
  };

  stylix.targets.waybar.enable = true;
}
