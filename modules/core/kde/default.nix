{ config, pkgs, ... }:

{
  ##############################################
  # KDE Plasma Desktop Core Config
  ##############################################
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Systemweite KDE Apps
  environment.systemPackages = with pkgs; [
    kdePackages.kate
    kdePackages.dolphin
    kdePackages.konsole
    kdePackages.okular
    kdePackages.gwenview
    kdePackages.kcalc
    kdePackages.kdeconnect-kde
    kdePackages.discover
    kdePackages.krunner
    pkgs.kdePackages.kwin
    papirus-icon-theme
  ];

  # Themes und Fonts importieren
  imports = [ ./themes.nix ];

  # Optional Wallpapers
  environment.etc."xdg/wallpapers".source = ../wallpapers;

  # Autostart-Scripts auf gemeinsamen Core-Ordner zeigen
  environment.etc."xdg/autostart-scripts".source = ../autostart-scripts;
}
