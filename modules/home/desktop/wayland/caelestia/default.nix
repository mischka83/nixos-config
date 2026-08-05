{ lib, config, pkgs, ... }:

let
  cfg = config.profile.desktop.wayland.caelestia;
  caelestiaSessionLauncher = pkgs.writeShellScript "caelestia-session-launcher" ''
    case "''${XDG_CURRENT_DESKTOP:-}:''${XDG_SESSION_DESKTOP:-}" in
      *[Cc]aelestia*) exec ${config.programs.caelestia.package}/bin/caelestia-shell ;;
      *) exit 0 ;;
    esac
  '';
in
{
  options.profile.desktop.wayland.caelestia.enable =
    lib.mkEnableOption "Caelestia Shell wayland profile";

  config = lib.mkIf cfg.enable {
    programs.caelestia = {
      enable = true;
      cli.enable = true;
      systemd.target = "graphical-session.target";
    };

    # Start the shell only when the current session is Hyprland.
    systemd.user.services.caelestia.Service.ExecStart = lib.mkForce caelestiaSessionLauncher;

    # Shared wayland helpers that are often required in non-Plasma sessions.
    home.packages = with pkgs; [
      xdg-utils
      shared-mime-info
      hicolor-icon-theme
      adwaita-icon-theme
    ];

  };
}
