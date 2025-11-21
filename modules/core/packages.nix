{ config, pkgs, ... }:

{
  # Hyperland Window Manager konfigurieren
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    hyprland = {
      enable = true;
      # set the flake package
      #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # make sure to also set the portal package, so that they are in sync
      #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      withUWSM = true;
    };

    # firefox.enable = true;  # Browser systemweit
    steam.enable = true;    # Spielplattform systemweit
    zoom-us.enable = true;  # Zoom Client systemweit
    obs-studio = {
      enable = true;
      # optional Nvidia hardware acceleration
      package = (
        pkgs.obs-studio.override {
          cudaSupport = true;
        }
      );

      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi #optional AMD hardware acceleration
        obs-gstreamer
        obs-vkcapture
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  # --- Systemweite Pakete ---
  environment.systemPackages = with pkgs; [
    # --- System-Tools ---
    pciutils stow ffmpeg clinfo tree mission-center usbutils

    # --- Development (Core, systemweit) ---
    nodejs powershell poetry 
    
    # --- Development (Container / Virtualisierung) ---
    winboat docker freerdp

    # --- KDE-Apps (Desktop-Grundausstattung) ---
    kdePackages.kate
    kdePackages.dolphin
    kdePackages.konsole
    kdePackages.okular
    kdePackages.gwenview
    kdePackages.kcalc
    kdePackages.kdeconnect-kde
    kdePackages.discover
    kdePackages.krunner
    papirus-icon-theme

    # --- Gaming Plattform ---
    adwsteamgtk

    # --- Hyprland Apps ---
    rofi waybar
  ];

}
