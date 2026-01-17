{ config, pkgs, ... }:

{
  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
  ];

  # Plasma Themes / Icons könnten hier referenziert werden
}
