{ config, pkgs, ... }:

{
  fonts.fonts = with pkgs; [
    jetbrains-mono
    noto-fonts
  ];

  # Plasma Themes / Icons könnten hier referenziert werden
}
