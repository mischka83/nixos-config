{ pkgs, ... }:

{
  # Add a separate Niri session in SDDM while keeping Plasma available.
  programs.niri = {
    enable = true;
    # Prefer gtk file chooser integration over pulling in Nautilus.
    useNautilus = false;
  };

  # Noctalia feature prerequisites.
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  security.polkit.enable = true;

  # Common user-facing tools expected by Niri defaults and X11 compatibility.
  environment.systemPackages = with pkgs; [
    alacritty
    fuzzel
    swaylock
    xwayland-satellite
  ];
}
