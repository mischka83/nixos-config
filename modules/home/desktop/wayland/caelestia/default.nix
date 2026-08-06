{ lib, config, pkgs, inputs, ... }:

let
  cfg = config.profile.desktop.wayland.caelestia;
  caelestiaPkg = inputs.caelestia-shell.packages.${pkgs.stdenv.hostPlatform.system}.caelestia-shell.override {
    hyprland = pkgs.hyprland;
  };
in
{
  options.profile.desktop.wayland.caelestia.enable =
    lib.mkEnableOption "Caelestia Shell wayland profile";

  config = lib.mkIf cfg.enable {
    programs.caelestia = {
      enable = true;
      package = caelestiaPkg;
      cli.enable = true;
      systemd.target = "graphical-session.target";
    };

    # Disable the default user-service autostart and start from Hyprland exec-once instead.
    systemd.user.services.caelestia.Install.WantedBy = lib.mkForce [ ];

    # Shared wayland helpers that are often required in non-Plasma sessions.
    home.packages = with pkgs; [
      alacritty
      fuzzel
      mako
      kanshi
      networkmanagerapplet
      libnotify
      wl-clipboard
      cliphist
      polkit_gnome
      xdg-utils
      shared-mime-info
      hicolor-icon-theme
      adwaita-icon-theme
    ];

    # Reuse the same display profiles from Niri in Caelestia/Hyprland.
    services.kanshi = {
      enable = true;
      systemdTarget = "graphical-session.target";
      settings = [
        {
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
          profile.name = "work-external-only";
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
              status = "disable";
            }
          ];
        }
        {
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

    # Profile switcher menu for kanshi in Caelestia sessions.
    xdg.configFile."hypr/kanshi-switcher.sh" = {
      text = builtins.readFile ../niri/kanshi-switcher.sh;
      executable = true;
    };

    # VPN connect/disconnect helper via NetworkManager profiles.
    xdg.configFile."hypr/vpn-switcher.sh" = {
      text = ''
        #!/usr/bin/env bash
        set -euo pipefail

        NMCLI_BIN="$(command -v nmcli 2>/dev/null || true)"
        FUZZEL_BIN="$(command -v fuzzel 2>/dev/null || true)"
        ALACRITTY_BIN="$(command -v alacritty 2>/dev/null || true)"
        NOTIFY_BIN="$(command -v notify-send 2>/dev/null || true)"

        notify() {
          local msg="$1"
          if [[ -n "$NOTIFY_BIN" ]]; then
            "$NOTIFY_BIN" "VPN" "$msg"
          fi
        }

        if [[ -z "$NMCLI_BIN" || -z "$FUZZEL_BIN" ]]; then
          notify "nmcli or fuzzel not found"
          exit 1
        fi

        all_vpns="$($NMCLI_BIN -t -f NAME,TYPE connection show | awk -F: '$2=="vpn" { print $1 }')"
        active_vpns="$($NMCLI_BIN -t -f NAME,TYPE connection show --active | awk -F: '$2=="vpn" { print $1 }')"

        if [[ -z "$all_vpns" ]]; then
          notify "No VPN profiles found in NetworkManager"
          exit 0
        fi

        menu_entries=""
        while IFS= read -r name; do
          [[ -z "$name" ]] && continue
          if printf '%s\n' "$active_vpns" | grep -Fxq "$name"; then
            menu_entries+="Disconnect: $name"$'\n'
          else
            menu_entries+="Connect: $name"$'\n'
          fi
        done <<< "$all_vpns"

        selection="$(printf '%s' "$menu_entries" | "$FUZZEL_BIN" --dmenu --prompt "VPN: ")"
        [[ -z "$selection" ]] && exit 0

        action="''${selection%%:*}"
        profile="''${selection#*: }"

        if [[ "$action" == "Disconnect" ]]; then
          if "$NMCLI_BIN" connection down id "$profile" >/dev/null 2>&1; then
            notify "Disconnected: $profile"
          else
            notify "Failed to disconnect: $profile"
            exit 1
          fi
          exit 0
        fi

        if "$NMCLI_BIN" connection up id "$profile" >/dev/null 2>&1; then
          notify "Connected: $profile"
          exit 0
        fi

        # Some VPNs require secrets at connect time; open an interactive terminal prompt.
        if [[ -n "$ALACRITTY_BIN" ]]; then
          "$ALACRITTY_BIN" -e bash -lc "nmcli --ask connection up id \"$profile\"; echo; echo 'Press Enter to close'; read"
        else
          notify "VPN needs credentials; run: nmcli --ask connection up id '$profile'"
        fi
      '';
      executable = true;
    };

    # Provide explicit Hyprland config so Caelestia does not rely on autogenerated defaults.
    xdg.configFile."hypr/hyprland.conf".text = ''
      # User-managed baseline settings for Caelestia/Hyprland sessions.
      $mainMod = SUPER
      $terminal = alacritty
      $launcher = fuzzel

      input {
        kb_layout = de
      }

      bind = $mainMod, Return, exec, $terminal
      bind = $mainMod, Space, exec, $launcher
      bind = $mainMod, D, exec, $launcher
      bind = $mainMod, Q, killactive
      bind = $mainMod SHIFT, E, exit
      bind = $mainMod, F, fullscreen
      bind = $mainMod, minus, resizeactive, -60 0
      bind = $mainMod, plus, resizeactive, 60 0
      bind = $mainMod, equal, resizeactive, 60 0
      bind = $mainMod SHIFT, minus, resizeactive, 0 -60
      bind = $mainMod SHIFT, plus, resizeactive, 0 60
      bind = $mainMod SHIFT, equal, resizeactive, 0 60
      bind = $mainMod SHIFT, V, exec, /home/mischka/.config/hypr/vpn-switcher.sh
      bind = $mainMod SHIFT, D, exec, /home/mischka/.config/hypr/kanshi-switcher.sh

      exec-once = ${config.programs.caelestia.package}/bin/caelestia-shell
      exec-once = nm-applet --indicator
      exec-once = polkit-gnome-authentication-agent-1
      exec-once = mako
      exec-once = wl-paste --type text --watch cliphist store
      exec-once = wl-paste --type image --watch cliphist store
    '';

  };
}
