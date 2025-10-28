{ config, pkgs, ... }:

{
  # Nerd Fonts für das System
  fonts = {
    packages = with pkgs; [
    nerd-fonts.droid-sans-mono 
    nerd-fonts.symbols-only 
    nerd-fonts.bigblue-terminal 
    nerd-fonts.heavy-data hurmit
    jetbrains-mono
    font-awesome
    dejavu_fonts
  ];
}