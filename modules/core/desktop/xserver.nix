{ config, pkgs, ... }:

{
  # SDDM runs on X11 for stability on this NVIDIA setup.
  # Plasma sessions can still run Wayland.
  services.xserver.enable = true;

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  hardware.graphics.enable = true;
}
