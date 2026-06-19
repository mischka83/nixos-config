{ lib, config, ... }:

let
  cfg = config.profile.desktop.niri;
in
{
  config = lib.mkIf cfg.enable {
    # Idle-Daemon: sperrt die Session nach 10 Min und direkt vor dem Suspend.
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          before_sleep_cmd = "loginctl lock-session";
          lock_cmd = "hyprlock";
          ignore_dbus_inhibit = false;
        };
        listener = [
          {
            timeout = 600;
            on-timeout = "loginctl lock-session";
          }
        ];
      };
    };

    # Sperrbildschirm: Screenshot des Desktops wird geblurrt als Hintergrund,
    # Uhrzeit, Benutzername und Passwort-Eingabefeld werden angezeigt.
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          hide_cursor = true;
        };

        background = [
          {
            monitor = "";
            path = "screenshot";
            blur_passes = 3;
            blur_size = 8;
            brightness = 0.6;
          }
        ];

        label = [
          {
            monitor = "";
            text = "cmd[update:1000] date +\"%H:%M\"";
            font_size = 80;
            font_family = "Noto Sans Bold";
            color = "rgba(255, 255, 255, 0.95)";
            position = "0, 280";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = "cmd[update:60000] date +\"%A, %d. %B %Y\"";
            font_size = 20;
            font_family = "Noto Sans";
            color = "rgba(255, 255, 255, 0.75)";
            position = "0, 190";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = "$USER";
            font_size = 18;
            font_family = "Noto Sans";
            color = "rgba(255, 255, 255, 0.70)";
            position = "0, -30";
            halign = "center";
            valign = "center";
          }
        ];

        input-field = [
          {
            monitor = "";
            size = "320, 52";
            outline_thickness = 2;
            dots_size = 0.28;
            dots_spacing = 0.15;
            outer_color = "rgba(255, 255, 255, 0.4)";
            inner_color = "rgba(0, 0, 0, 0.45)";
            font_color = "rgb(255, 255, 255)";
            fade_on_empty = true;
            placeholder_text = "<i>Passwort…</i>";
            fail_text = "<i>Falsches Passwort</i>";
            position = "0, -90";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };
  };
}
