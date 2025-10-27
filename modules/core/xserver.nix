{ inputs, config, pkgs, ... }:

{
  # Tastatur-Layouts
  services.xserver = {
    enable = true;
    xkb = {
      layout = "de";
      variant = "";
    };
  };
}