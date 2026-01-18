{ pkgs, config, ... }:

{
  ##############################################
  # 🔹 Host-spezifische Pakete & Services
  ##############################################
  environment.systemPackages = with pkgs; [
    jetbrains.rider
    adwsteamgtk
  ];

  programs.steam.enable = true;
  zoom-us.enable = true;

  ##############################################
  # 🔹 Virtualisierung nur auf dieser Workstation
  ##############################################
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableKvm = true;
  virtualisation.virtualbox.host.addNetworkInterface = false;

  users.extraGroups.vboxusers.members = [ "mischka" ];

  obs-studio = {
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
}
