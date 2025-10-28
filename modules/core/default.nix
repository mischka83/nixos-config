{ config, pkgs, ... }:

{
imports = [
    ./boot.nix
    ./hardware.nix
    ./network.nix
    ./sddm.nix
    ./security.nix
    ./services.nix
    ./system.nix
    ./xserver.nix
  ];

}