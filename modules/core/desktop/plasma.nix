{ config, pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;

  # Power Button – direkter Standby-Modus ohne Abfrage (systemd logind)
  services.logind.settings.Login.HandlePowerKey = "suspend";

  # Essential KDE Plasma applications
  environment.systemPackages = with pkgs; [
    # Core KDE Applications
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

    kdePackages.kconfig
  ];
}
