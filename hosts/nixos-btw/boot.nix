{ config, pkgs, ... }:

{
  ##############################################
  # 🥷 Lenovo Legion – Hybrid NVIDIA Setup
  ##############################################

  boot = {
    kernelParams = [
      "nvidia-drm.modeset=1"
      "ibt=off"
    ];

    initrd.kernelModules = [
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
    ];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = false;
    nvidiaSettings = true;
  };
}
