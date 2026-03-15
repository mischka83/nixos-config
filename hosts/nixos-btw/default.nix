{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core/default.nix
    ../../modules/optional/bluetooth.nix
    ../../modules/optional/gaming/default.nix
    ../../modules/optional/nvidia-hybrid.nix
    ../../modules/optional/tpm2-luks.nix
  ];

  networking.hostName = "nixos-btw";

  system.stateVersion = "25.11";
}
