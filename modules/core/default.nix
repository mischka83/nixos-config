{ config, pkgs, ... }:

{
  ##############################################
  # 🧩 Core Module Imports
  ##############################################
  # Alle modularen Core-Funktionen werden hier importiert.
  # Prinzip: ein Modul = eine logische Systemfunktion.
  imports = [

    ############################################################################
    # 🔹 System- und Wartungs-Module
    ############################################################################
    ./auto-upgrade.nix       # Flake-basierte automatische Updates
    ./boot.nix               # Bootloader & Kernel-Einstellungen
    ./gc.nix                 # Nix Garbage Collection
    ./system.nix             # Systemweite Optionen (locale, time, hostname)
    ./users.nix              # Benutzer-Accounts & Gruppen

    ############################################################################
    # 🔹 Hardware, Netzwerk & Virtualisierung
    ############################################################################
    ./hardware.nix           # Core Hardware-Einstellungen
    ./network.nix            # Netzwerk-Module
    ./virtualisation.nix     # Virtualisierung & VM Tools

    ############################################################################
    # 🔹 Software / Services
    ############################################################################
    ./packages.nix           # Core-Pakete, DE/WM-neutral
    ./flatpak.nix            # Flatpak-Setup
    ./fonts.nix              # Schriftarten
    ./services.nix           # Core Services (Pipewire, fwupd, libinput etc.)
    ./security.nix           # Sicherheits- & Firewall-Einstellungen
    ./sddm.nix               # Display Manager (Core-neutral)
    ./xserver.nix            # Xorg / Wayland / Desktop-Einstellungen

    ############################################################################
    # 🔹 Desktop Environments / Window Manager
    ############################################################################
    ./kde/default.nix        # KDE Plasma + Core Apps, Themes, Autostart
    ./hyprland/default.nix   # Hyprland + Bar, Rofi, Themes, Autostart
  ];
}
