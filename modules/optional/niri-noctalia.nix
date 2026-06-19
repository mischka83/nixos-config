{ pkgs, ... }:

{
  # Add a separate Niri session in SDDM while keeping Plasma available.
  programs.niri = {
    enable = true;
    # Prefer gtk file chooser integration over pulling in Nautilus.
    useNautilus = false;
  };

  # Portal services are required for file pickers in Electron/GTK apps on Wayland.
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  # Improve Electron app behavior in Wayland sessions (VS Code, Discord, etc.).
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GTK_USE_PORTAL = "1";
  };

  # Noctalia feature prerequisites.
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  security.polkit.enable = true;

  # Provide a desktop-agnostic Secret Service backend for Chromium/Electron
  # apps in Niri sessions and unlock it on SDDM login.
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.sddm.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;

  # Required so hyprlock can authenticate via PAM.
  security.pam.services.hyprlock = {};

  # Common user-facing tools expected by Niri defaults and X11 compatibility.
  environment.systemPackages = with pkgs; [
    alacritty
    fuzzel
    xwayland-satellite
  ];
}
