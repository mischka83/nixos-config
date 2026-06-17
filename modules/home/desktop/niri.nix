{ lib, config, ... }:

let
  cfg = config.profile.desktop.niri;
in
{
  options.profile.desktop.niri.enable = lib.mkEnableOption "Niri + Noctalia desktop profile";

  config = lib.mkIf cfg.enable {
    # Noctalia configuration module. Startup itself is handled by Niri.
    programs.noctalia = {
      enable = true;
      systemd.enable = false;
      settings = {
        theme.mode = "dark";
        wallpaper.directory = "~/Pictures";
        bar.default.margin_ends = 10;
      };
    };

    # Keep Niri-specific customizations in a separate include file.
    xdg.configFile."niri/noctalia-autostart.kdl".text = ''
      // Start Noctalia automatically in Niri sessions.
      spawn-at-startup "noctalia"

      // Include Noctalia generated theme snippets when available.
      include "./noctalia.kdl"
    '';

    # Ensure include target always exists so `niri validate` does not fail
    # before Noctalia generated snippets are present.
    xdg.configFile."niri/noctalia.kdl".text = ''
      // Intentionally empty fallback file for Noctalia include.
    '';

    # Layout-safe overrides for keys that differ between keyboard layouts.
    xdg.configFile."niri/keybind-overrides.kdl".text = ''
      binds {
        // Alternative to Mod+Shift+Slash for the hotkey help overlay.
        Mod+F1 { show-hotkey-overlay; }

        // Keep "increase width" working on German layouts where + is its own keysym.
        Mod+Plus { set-column-width "+10%"; }

        // Keep "increase height" working when + is not on the US Equal key.
        Mod+Shift+Plus { set-window-height "+10%"; }

        // Some layouts emit Asterisk when Shift is held on the + key.
        Mod+Asterisk { set-window-height "+10%"; }

        // Alternatives for US BracketLeft/BracketRight actions.
        Mod+Z { consume-or-expel-window-left; }
        Mod+X { consume-or-expel-window-right; }

        // Alternatives for US Comma/Period actions.
        Mod+N { consume-window-into-column; }
        Mod+Shift+N { expel-window-from-column; }
      }
    '';

    # Keep monitor arrangement stable: external HDMI monitor left of laptop panel.
    xdg.configFile."niri/monitor-layout.kdl".text = ''
      output "HDMI-A-1" {
        position x=-3440 y=0
      }

      output "eDP-1" {
        position x=0 y=0
      }
    '';

    # If niri config already exists, inject our include exactly once.
    # If it does not exist yet (first Niri login), we leave it untouched.
    home.activation.ensureNiriIncludes = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      cfg="$HOME/.config/niri/config.kdl"
      if [ -f "$cfg" ]; then
        # Remove legacy include from previous nm-applet setup.
        sed -i '/include "\.\/networkmanager\.kdl"/d' "$cfg"

        if ! grep -Fq 'include "./noctalia-autostart.kdl"' "$cfg"; then
          printf '\ninclude "./noctalia-autostart.kdl"\n' >> "$cfg"
        fi

        if ! grep -Fq 'include "./keybind-overrides.kdl"' "$cfg"; then
          printf 'include "./keybind-overrides.kdl"\n' >> "$cfg"
        fi

        if ! grep -Fq 'include "./monitor-layout.kdl"' "$cfg"; then
          printf 'include "./monitor-layout.kdl"\n' >> "$cfg"
        fi
      fi
    '';
  };
}
