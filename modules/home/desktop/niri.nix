{ lib, config, pkgs, ... }:

let
  cfg = config.profile.desktop.niri;
in
{
  options.profile.desktop.niri.enable = lib.mkEnableOption "Niri + Noctalia desktop profile";

  config = lib.mkIf cfg.enable {
    # Agents needed in bare Wayland sessions so NM can ask for VPN secrets.
    home.packages = with pkgs; [
      networkmanagerapplet
      polkit_gnome
      xdg-utils
      shared-mime-info
      zathura
      imv
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
    xdg.configFile."niri/noctalia-autostart.kdl".text = ''
      // Start Noctalia automatically in Niri sessions.
      spawn-at-startup "noctalia"
      // Provide NM secret prompts and tray handling for VPN connections.
      spawn-at-startup "nm-applet --indicator"
      // Required so privileged session actions can open an auth dialog.
      spawn-at-startup "polkit-gnome-authentication-agent-1"

      // Include Noctalia generated theme snippets when available.
      include "./noctalia.kdl"
    '';

    # Ensure include target always exists so `niri validate` does not fail
    # before Noctalia generated snippets are present.
    xdg.configFile."niri/noctalia.kdl".text = ''
      // Intentionally empty fallback file for Noctalia include.
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

        if ! grep -Fq 'include "./noctalia-autostart.kdl"' "$cfg"; then
          printf '\ninclude "./noctalia-autostart.kdl"\n' >> "$cfg"
        fi

        if ! grep -Fq 'include "./keybind-overrides.kdl"' "$cfg"; then
          printf 'include "./keybind-overrides.kdl"\n' >> "$cfg"
        fi
      fi
    '';
  };
}
