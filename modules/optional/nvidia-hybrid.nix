{ lib, config, ... }:

{
  # NVIDIA Hybrid GPU Configuration for Lenovo Legion
  #
  # This module configures a hybrid GPU setup with:
  # - AMD Integrated GPU (iGPU) as primary
  # - NVIDIA dedicated GPU for offloading
  #
  # Usage: Import in your host configuration if you have hybrid graphics
  # Benefits:
  #   - Better power efficiency (uses iGPU by default)
  #   - Can offload demanding apps to NVIDIA GPU
  #   - nvidia-offload command available for per-app GPU selection
  #
  # Example usage:
  #   nvidia-offload glxgears     # Run glxgears on NVIDIA GPU
  #   nvidia-offload steam        # Run Steam on NVIDIA GPU

  hardware.nvidia = {
    open = false;                        # Proprietären Treiber verwenden
    modesetting.enable = true;           # Modesetting für Wayland erforderlich
    nvidiaSettings = true;               # nvidia-settings GUI aktivieren
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    powerManagement.enable = true;       # Suspend/resume-Unterstützung für dGPU
    powerManagement.finegrained = true;  # dGPU bei Nicht-Nutzung vollständig abschalten

    prime = {
      offload.enable = true;             # AMD iGPU als Standard, NVIDIA per nvidia-offload
      amdgpuBusId = lib.mkForce "PCI:6:0:0";
      nvidiaBusId = lib.mkForce "PCI:1:0:0";
    };
  };
}
