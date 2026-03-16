{ config, pkgs, ... }:

{
  # Kein X11-Server nötig – Plasma 6 läuft nativ unter Wayland.
  # XKB-Layout wird trotzdem gesetzt (NixOS übernimmt es in die systemd-Konfiguration).
  services.xserver.enable = false;

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  hardware.graphics.enable = true;
}
