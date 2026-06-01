{ inputs, ... }:

{
  programs.plasma.workspace = {
    theme      = "breeze-dark";
    lookAndFeel = "org.kde.breezedark.desktop";

    # Wallpaper für Desktop
    wallpaper = inputs.silentSDDM + "/backgrounds/smoky.jpg";
  };

  # Plasma-Lockscreen ist getrennt von SDDM; setze ihn explizit auf dasselbe Bild.
  programs.plasma.kscreenlocker.appearance.wallpaper =
    inputs.silentSDDM + "/backgrounds/smoky.jpg";
}
