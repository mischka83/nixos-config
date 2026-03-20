{ inputs, ... }:

{
  programs.plasma.workspace = {
    theme      = "breeze-dark";
    lookAndFeel = "org.kde.breezedark.desktop";

    # Repo-lokales Wallpaper als echter Nix-Pfad.
    # wallpaper = ../../../../assets/wallpapers/nixos-tech-minimal-21x9.svg;
  };

  # Plasma-Lockscreen ist getrennt von SDDM; setze ihn explizit auf dasselbe Bild.
  programs.plasma.kscreenlocker.appearance.wallpaper =
    inputs.silentSDDM + "/backgrounds/smoky.jpg";
}
