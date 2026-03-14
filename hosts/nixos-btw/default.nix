{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/core/default.nix
  ];

  networking.hostName = "nixos-btw";

  system.stateVersion = "25.11";
}
