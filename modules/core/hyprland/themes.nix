{ config, pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    jetbrains-mono
    noto-fonts
  ];

  # GTK / Bar Themes hier referenzieren
}
