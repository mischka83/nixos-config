{ pkgs, ... }:

{
  # KDE Plasma Dark Theme Konfiguration
  qt = {
    enable = true;
    platformTheme.name = "kde";
    style.name = "breeze-dark";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze;
    };
    iconTheme = {
      name = "breeze";
      package = pkgs.kdePackages.breeze-icons;
    };
  };

  # Nerd Fonts Installation
  home.packages = with pkgs; [
    # Nerd Fonts (monospace fonts with icons)
    nerdfonts

    # Individual popular Nerd Fonts (leaner alternative to nerdfonts package)
    # Uncomment if you prefer smaller download:
    # (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" "Meslo" ]; })

    # KDE Plasma Theme packages
    kdePackages.breeze
    kdePackages.breeze-icons
  ];

  # Optional: Configure default fonts
  home.sessionVariables = {
    TERM = "xterm-256color";
  };
}
