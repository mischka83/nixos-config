{ config, pkgs, ... }:

{
  services.displayManager.sddm = {
    enable = true;
    theme  = "breeze";

    # SDDM-Hintergrundbild systemweit setzen (gleicher NixOS-Wallpaper wie der Desktop).
    settings.Theme.Background =
      "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray}/share/backgrounds/nixos/nix-wallpaper-nineish-dark-gray.png";
  };
}
