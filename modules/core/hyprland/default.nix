{ config, pkgs, ... }:

{
  ##############################################
  # Hyprland Core Config
  ##############################################
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;

  # Hyprland Apps
  environment.systemPackages = with pkgs; [
    rofi
    waybar
  ];

  # Themes / Fonts importieren
  imports = [ ./themes.nix ];

  # Optional Wallpapers
  environment.etc."xdg/wallpapers".source = ./wallpapers;

  # Autostart-Scripts auf gemeinsamen Core-Ordner zeigen
  environment.etc."xdg/autostart-scripts".source = ../autostart-scripts;
}
