{ ... }:

{
  # Optional profile for BIOS dGPU-only mode.
  # Use this module instead of nvidia-hybrid when iGPU is disabled in BIOS.
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = false;
    modesetting.enable = true;

    # Keeps the NVIDIA device initialized to reduce wake-up latency spikes.
    nvidiaPersistenced = true;
  };
}
