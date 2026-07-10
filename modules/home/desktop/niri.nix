{ lib, config, pkgs, ... }:

let
  cfg = config.profile.desktop.niri;
  palette = {
    bg = "#0F1720";
    surface = "#16202B";
    surfaceAlt = "#1D2A38";
    text = "#E6EDF3";
    textMuted = "#9FB0C0";
    accent = "#3ECF8E";
    accentSoft = "#2AAE78";
  };
in
{
  options.profile.desktop.niri.enable = lib.mkEnableOption "Niri + DankMaterialShell desktop profile";

  config = lib.mkIf cfg.enable {
    # Agents needed in bare Wayland sessions so NM can ask for VPN secrets.
    home.packages = with pkgs; [
      networkmanagerapplet
      polkit_gnome
      gnome-disk-utility
      xdg-utils
      shared-mime-info
      zathura
      imv
      dms-shell
    ];

    # Explicit file associations for minimal Wayland sessions.
    # Without this, xdg-open can fall back to the browser for many file types.
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = [ "org.pwmt.zathura.desktop" "zathura.desktop" ];
        "application/postscript" = [ "org.pwmt.zathura.desktop" "zathura.desktop" ];

        "image/jpeg" = [ "imv.desktop" ];
        "image/png" = [ "imv.desktop" ];
        "image/webp" = [ "imv.desktop" ];
        "image/gif" = [ "imv.desktop" ];
        "image/bmp" = [ "imv.desktop" ];
        "image/tiff" = [ "imv.desktop" ];
        "image/svg+xml" = [ "imv.desktop" ];
        "image/avif" = [ "imv.desktop" ];

        "inode/directory" = [ "org.kde.dolphin.desktop" ];
      };
      associations.added = {
        "application/pdf" = [ "org.pwmt.zathura.desktop" "zathura.desktop" ];
        "application/postscript" = [ "org.pwmt.zathura.desktop" "zathura.desktop" ];

        "image/jpeg" = [ "imv.desktop" ];
        "image/png" = [ "imv.desktop" ];
        "image/webp" = [ "imv.desktop" ];
        "image/gif" = [ "imv.desktop" ];
        "image/bmp" = [ "imv.desktop" ];
        "image/tiff" = [ "imv.desktop" ];
        "image/svg+xml" = [ "imv.desktop" ];
        "image/avif" = [ "imv.desktop" ];
      };
    };

    # Palette reference for consistent theming across modules:
    # bg=${palette.bg} surface=${palette.surface} surface-alt=${palette.surfaceAlt}
    # text=${palette.text} muted=${palette.textMuted}
    # accent=${palette.accent} accent-soft=${palette.accentSoft}

    # Automatic output switching for home/work docking setups.
    # Kanshi matches a profile only when ALL listed outputs are physically connected.
    # Do NOT list outputs from the other location – they won't be present and
    # would prevent the profile from matching.
    services.kanshi = {
      enable = true;
      systemdTarget = "graphical-session.target";
      settings = [
        {
          # Home: one external HDMI monitor to the left of the laptop panel.
          profile.name = "home";
          profile.outputs = [
            {
              criteria = "HDMI-A-1";
              status = "enable";
              position = "0,0";
            }
            {
              criteria = "eDP-1";
              status = "enable";
              position = "3440,0";
            }
          ];
        }
        {
          # Work: two USB-C Philips monitors (DP-3 left, DP-2 right) plus laptop.
          profile.name = "work";
          profile.outputs = [
            {
              criteria = "DP-2";
              status = "enable";
              position = "0,0";
            }
            {
              criteria = "DP-3";
              status = "enable";
              position = "1920,0";
            }
            {
              criteria = "eDP-1";
              status = "enable";
              position = "3840,0";
            }
          ];
        }
        {
          # Home variant: external 34" only, laptop panel disabled.
          # Keep after "home" so normal home auto-matching remains the default.
          profile.name = "home-external-only";
          profile.outputs = [
            {
              criteria = "HDMI-A-1";
              status = "enable";
              position = "0,0";
            }
            {
              criteria = "eDP-1";
              status = "disable";
            }
          ];
        }
        {
          # Fallback: laptop panel only.
          # Keep this after home/work so docking profiles win when they match.
          profile.name = "laptop-only";
          profile.outputs = [
            {
              criteria = "eDP-1";
              status = "enable";
              position = "0,0";
            }
          ];
        }
      ];
    };

    # Keep Niri-specific customizations in a separate include file.
    xdg.configFile."niri/dms-autostart.kdl".text = ''
      // Start DankMaterialShell automatically in Niri sessions.
      spawn-at-startup "dms run"
      // Provide NM secret prompts and tray handling for VPN connections.
      spawn-at-startup "nm-applet --indicator"
      // Required so privileged session actions can open an auth dialog.
      spawn-at-startup "polkit-gnome-authentication-agent-1"

      // Include DMS-generated snippets when available.
      include "./dms/outputs.kdl"
      include "./dms/layout.kdl"
      include "./dms/windowrules.kdl"
      include "./dms/cursor.kdl"
      include "./dms/binds.kdl"
    '';

    # Ensure include target always exists so `niri validate` does not fail
    # before DMS generated snippets are present.
    xdg.configFile."niri/dms/outputs.kdl".text = ''
      // Intentionally empty fallback file for DMS include.
    '';

    xdg.configFile."niri/dms/layout.kdl".text = ''
      // Intentionally empty fallback file for DMS include.
    '';

    xdg.configFile."niri/dms/windowrules.kdl".text = ''
      // Intentionally empty fallback file for DMS include.
    '';

    xdg.configFile."niri/dms/cursor.kdl".text = ''
      // Intentionally empty fallback file for DMS include.
    '';

    xdg.configFile."niri/dms/binds.kdl".text = ''
      // Intentionally empty fallback file for DMS include.
    '';

    # Kanshi profile switcher script.
    xdg.configFile."niri/kanshi-switcher.sh" = {
      text = builtins.readFile ./kanshi-switcher.sh;
      executable = true;
    };

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

        // Switch Kanshi display profiles via menu.
        Mod+Shift+D { spawn "/home/mischka/.config/niri/kanshi-switcher.sh"; }
      }
    '';

    # If niri config already exists, inject our include exactly once.
    # If it does not exist yet (first Niri login), we leave it untouched.
    home.activation.ensureNiriIncludes = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      cfg="$HOME/.config/niri/config.kdl"
      if [ -f "$cfg" ]; then
        # Remove legacy include from previous nm-applet setup.
        sed -i '/include "\.\/networkmanager\.kdl"/d' "$cfg"

        if ! grep -Fq 'include "./dms-autostart.kdl"' "$cfg"; then
          printf '\ninclude "./dms-autostart.kdl"\n' >> "$cfg"
        fi

        sed -i '/include "\.\/noctalia-autostart\.kdl"/d' "$cfg"

        if ! grep -Fq 'include "./keybind-overrides.kdl"' "$cfg"; then
          printf 'include "./keybind-overrides.kdl"\n' >> "$cfg"
        fi
      fi
    '';
  };
}
