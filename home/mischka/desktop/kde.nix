{ pkgs, ... }:

{
  # KDE Plasma Dark Theme Konfiguration
  qt = {
    enable = true;
    platformTheme.name = "kde";
    style.name = "breeze";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze;
    };
    iconTheme = {
      name = "breeze-icons";
      package = pkgs.kdePackages.breeze-icons;
    };
  };

  # Nerd Fonts Installation - konkrete Fonts
  home.packages = with pkgs; [
    # Nerd Fonts (einzeln, um Speicher zu sparen)
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Meslo" ]; })

    # KDE Plasma Theme packages
    kdePackages.breeze
    kdePackages.breeze-icons
  ];

  # Session Variable für Terminal
  home.sessionVariables = {
    TERM = "xterm-256color";
  };
}
