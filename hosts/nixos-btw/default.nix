{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core/default.nix
    ../../modules/optional/bluetooth.nix
    ../../modules/optional/nvidia-hybrid.nix
  ];

  networking.hostName = "nixos-btw";

  system.stateVersion = "25.11";
}
