{ config, pkgs, ... }:

{
  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 32;
      };
      iconTheme = "Papirus-Dark";
    };
    fonts = {
      general = {
        family = "JetBrains Mono";
        pointSize = 12;
      };
    };
  };


}