{ config, pkgs, ... }:

{
  # Hyperland Window Manager konfigurieren
  programs.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    withUWSM = true;
  };

  nixpkgs.config.allowUnfree = true;

  # --- Systemweite Pakete ---
  environment.systemPackages = with pkgs; [
    # --- System-Tools ---
    pciutils stow ffmpeg clinfo tree mission-center usbutils

    # --- Development (Core, systemweit) ---
    nodejs powershell

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

    # --- Gaming Plattform ---
    adwsteamgtk

    # --- Hyprland Apps ---
    rofi waybar
  ];

  # Programme, die systemweit aktiviert werden
  programs = {
    firefox.enable = true;  # Browser systemweit
    steam.enable = true;    # Spielplattform systemweit
  };

  # Nerd Fonts für das System
  fonts.packages = with pkgs.nerd-fonts; [
    droid-sans-mono symbols-only bigblue-terminal heavy-data hurmit
  ];

  # Flatpak (Flathub)
  services.flatpak.enable = true;
  environment.etc."flatpak/remotes.d/flathub.flatpakrepo".source = pkgs.fetchurl {
    url = "https://flathub.org/repo/flathub.flatpakrepo";
    sha256 = "0fm0zvlf4fipqfhazx3jdx1d8g0mvbpky1rh6riy3nb11qjxsw9k";
  };
}
