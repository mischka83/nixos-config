{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core/default.nix
    ../../modules/optional/bluetooth.nix
    ../../modules/optional/flatpak.nix
    ../../modules/optional/gaming/default.nix

    # GPU profile toggle (enable exactly one):
    # - Hybrid (AMD iGPU + NVIDIA offload): better battery/runtime efficiency
    # - dGPU-only (NVIDIA only): often more stable with external monitors
    # ../../modules/optional/nvidia-hybrid.nix
    ../../modules/optional/nvidia-dgpu-only.nix

    ../../modules/optional/tpm2-luks.nix
  ];

  networking.hostName = "nixos-btw";

  system.stateVersion = "26.05";
}
