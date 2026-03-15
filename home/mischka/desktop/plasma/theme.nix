{ ... }:

{
  programs.plasma.workspace = {
    theme      = "breeze-dark";
    lookAndFeel = "org.kde.breezedark.desktop";

    # Repo-lokales Wallpaper. Als git-getrackte Pfadreferenz landet es sauber im Store.
    wallpaper = "${../../../../assets/wallpapers/nixos-tech-minimal-21x9.svg}";
  };
}
