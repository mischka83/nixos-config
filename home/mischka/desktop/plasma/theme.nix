{ pkgs, ... }:

{
  programs.plasma.workspace = {
    theme      = "breeze-dark";
    lookAndFeel = "org.kde.breezedark.desktop";

    # NixOS-Wallpaper aus dem offiziellen nixos-artwork-Paket.
    # Die Variante "nineish-dark-gray" passt gut zum Breeze-Dark-Theme.
    wallpaper = "${pkgs.nixos-artwork.wallpapers.nineish-dark-gray}/share/wallpapers/nineish-dark-gray/contents/images/nix-wallpaper-nineish-dark-gray.png";
  };
}
