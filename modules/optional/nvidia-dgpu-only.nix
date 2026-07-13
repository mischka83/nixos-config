{ lib, ... }:

{
  # Optional profile for BIOS dGPU-only mode.
  # Use this module instead of nvidia-hybrid when iGPU is disabled in BIOS.
  services.xserver.videoDrivers = lib.mkForce [ "nvidia" ];

  hardware.nvidia = {
    open = false;
    modesetting.enable = true;

    # The hardware profile for this laptop enables PRIME offload by default.
    # In BIOS dGPU-only mode that hybrid setup can make Xorg fail with
    # "No devices detected" / "no screens found" at SDDM startup.
    prime = {
      offload.enable = lib.mkForce false;
      sync.enable = lib.mkForce false;
      reverseSync.enable = lib.mkForce false;
      amdgpuBusId = lib.mkForce "";
      intelBusId = lib.mkForce "";
    };

    # Keeps the NVIDIA device initialized to reduce wake-up latency spikes.
    nvidiaPersistenced = true;
  };
}
