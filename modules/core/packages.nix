{ config, pkgs, ... }:

let
  host = config.networking.hostName;
in
{
  ##############################################
  # 🔹 Core Programme (Host-unabhängig)
  ##############################################
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;  # Neovim als Standardeditor
    };
  };

  ##############################################
  # 🔹 Nixpkgs Konfiguration
  ##############################################
  nixpkgs.config.allowUnfree = true;

  ##############################################
  # 🔹 Systemweite Pakete (Core, alle Hosts)
  ##############################################
  environment.systemPackages = with pkgs; [
    # --- System-Tools ---
    pciutils stow ffmpeg clinfo tree mission-center usbutils

    # --- Development Tools ---
    nodejs powershell

    # --- Development (Container / Virtualisierung) ---
    freerdp
  ]
  # --- Host-spezifische Core Packages ---
  ++ (if host == "nixos-btw" then [
    pkgs.jetbrains.rider    # JetBrains Rider nur auf dieser Workstation
    pkgs.adwsteamgtk        # Steam GTK Integration
  ] else []);

  ##############################################
  # 🔹 Host-spezifische Programme / Services
  ##############################################
  programs.steam.enable = host == "nixos-btw";
}
