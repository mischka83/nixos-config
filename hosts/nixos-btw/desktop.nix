{ inputs, config, pkgs, ... }:

{
 
  # KDE Plasma 6 aktivieren
  services.desktopManager.plasma6.enable = true;

  # Hyperland Window Manager konfigurieren
  programs.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    withUWSM = true;
  };




}
