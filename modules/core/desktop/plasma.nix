{ config, pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;

  # logind fallback policy so power actions stay consistent across sessions.
  services.logind.settings.Login = {
    # Power Button – direkter Standby-Modus ohne Abfrage.
    HandlePowerKey = "suspend";
    # Erzwingt logind-Aktion auch wenn ein DE den Key abfangen will.
    PowerKeyIgnoreInhibited = "yes";

    # Suspend on lid close (battery, AC and docked/external-monitor scenarios).
    HandleLidSwitch = "suspend";
    HandleLidSwitchExternalPower = "suspend";
    HandleLidSwitchDocked = "suspend";
    # Keep inhibitors respected (e.g. critical updates/media scenarios).
    LidSwitchIgnoreInhibited = "no";
  };

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
