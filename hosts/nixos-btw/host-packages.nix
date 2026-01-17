{ pkgs, ... }:

{
  ##############################################
  # 🔹 Host-spezifische systemweite Packages
  ##############################################
  environment.systemPackages = with pkgs; [
    # --- Development Tools ---
    jetbrains.rider       # Nur auf dieser Workstation benötigt

    # --- Productivity ---
    zoom-us               # Zoom Client systemweit aktiv

    # --- Gaming / Steam Integration ---
    adwsteamgtk           # GTK Integration für Steam auf Wayland
  ];

  ##############################################
  # 🔹 Host-spezifische Programme / Services
  ##############################################
  programs = {
    # --- Gaming / Entertainment ---
    steam.enable = true;   # Steam nur auf dieser Workstation

    # --- Streaming / Recording ---
    obs-studio = {
      enable = true;       # OBS Studio aktivieren
      # Optional: Nvidia Hardware Acceleration
      package = pkgs.obs-studio.override {
        cudaSupport = true;
      };
      # OBS Plugins
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs                       # Wayland OBS Integration
        obs-backgroundremoval         # Background removal plugin
        obs-pipewire-audio-capture   # Pipewire Audio Capture
        obs-vaapi                     # AMD Video Acceleration (optional)
        obs-gstreamer                 # GStreamer Integration
        obs-vkcapture                 # Vulkan Capture Plugin
      ];
    };
  };
}
