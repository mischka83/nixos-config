{ lib, ... }:

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

  hardware.nvidia.prime = {
    # Enable offload mode: use AMD iGPU by default, offload to NVIDIA when needed
    offload.enable = true;

    amdgpuBusId = lib.mkForce "PCI:6:0:0";
    nvidiaBusId = lib.mkForce "PCI:1:0:0";

  };

  # Optional: Uncomment if you experience Wayland-specific issues
  # Experimental NVIDIA Wayland support (may help with external monitor freezing)
  hardware.nvidia.open = false;
  hardware.nvidia.modesetting.enable = true;

  # Optional: For debugging GPU issues, useful tools are already included:
  # - glxinfo: Check OpenGL status and GPU info
  # - lspci: List PCI devices (including GPU)
}
