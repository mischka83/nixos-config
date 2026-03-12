{ ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/core/boot.nix
    ../../modules/core/networking.nix
    ../../modules/core/users.nix
    ../../modules/core/packages.nix
  ];
  
  networking.hostName = "nixos-btw";

  system.stateVersion = "25.11"; 
}