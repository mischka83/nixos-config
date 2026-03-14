{ ... }:

{
  programs.plasma.workspace = {
    theme = "breeze-dark";
    lookAndFeel = "org.kde.breezedark.desktop";
  };


  programs.plasma.kwin.effects = {
    blur = {
      enable = true;
    };

    translucency = {
      enable = true;
    };
  };
}
