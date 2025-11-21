{ config, pkgs, ... }:

{
imports = [
    ./boot.nix
    ./docker.nix
    ./flatpak.nix
    ./fonts.nix
    ./hardware.nix
    ./network.nix
    ./packages.nix
    ./sddm.nix
    ./security.nix
    ./services.nix
    ./system.nix
    ./users.nix
    ./xserver.nix
  ];

}