{ config, pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;

  # KDE Plasma Dark Theme - System-wide
  environment.etc."xdg/kdeglobals".text = ''
    [General]
    ColorScheme=BreezeDark
    font=Noto Sans,11,-1,5,50,0,0,0,0,0
    menuFont=Noto Sans,11,-1,5,50,0,0,0,0,0
    smallestReadableFont=Noto Sans,8,-1,5,50,0,0,0,0,0
    toolBarFont=Noto Sans,11,-1,5,50,0,0,0,0,0

    [Icons]
    Theme=breeze-dark
  '';

  # Essential and recommended KDE Plasma applications
  environment.systemPackages = with pkgs; [
    # Core KDE Applications (ESSENTIAL)
    kdePackages.kate                     # Advanced text editor with syntax highlighting
    kdePackages.konsole                  # Default KDE terminal emulator
    kdePackages.okular                   # Feature-rich PDF viewer and document reader
    kdePackages.dolphin-plugins          # File manager extensions

    # KDE Applications (RECOMMENDED)
    kdePackages.gwenview                 # Fast and lightweight image viewer
    kdePackages.spectacle                # Screenshot and screen recording tool

    # KDE Themes & Breeze
    kdePackages.breeze
    kdePackages.breeze-icons

    # Optional Creative Tools (uncomment if needed)
    # kdePackages.kdenlive              # Video editor
    # kdePackages.krita                 # Digital painting and illustration
  ];
}
