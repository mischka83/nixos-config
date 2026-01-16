{ config, pkgs, ... }:

{
  ##############################################
  # 🧩 Imports (Modular)
  ##############################################
  imports = [
    ../../modules/core
    ./hardware.nix
    ./host-packages.nix
  ];

  networking.hostName = "nixos"; # Define your hostname.

  services.printing.enable = true;




}
