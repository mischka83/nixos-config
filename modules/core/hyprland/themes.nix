{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
  ];

  # GTK / Bar Themes hier referenzieren
}
