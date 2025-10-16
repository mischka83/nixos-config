{ config, pkgs, ... }:

{
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;

  # Tastatur-Layouts
  services.xserver.xkb.layout = "de";
  console.keyMap = "de";
}
