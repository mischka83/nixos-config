{ pkgs, config, ... }:

{
  ##############################################
  # 🔹 Host-spezifische Pakete & Services
  ##############################################
  environment.systemPackages = with pkgs; [
    jetbrains.rider
    adwsteamgtk
    freecad
    zed-editor
    google-chrome
    via
  ];

  programs.steam.enable = true;
  programs.zoom-us.enable = true;
  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override { cudaSupport = true; };
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi
      obs-gstreamer
      obs-vkcapture
    ];
  };

  ##############################################
  # 🔹 Virtualisierung nur auf dieser Workstation
  ##############################################
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableKvm = true;
  virtualisation.virtualbox.host.addNetworkInterface = false;

  users.extraGroups.vboxusers.members = [ "mischka" ];

}
