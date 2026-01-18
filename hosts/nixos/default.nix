{ config, pkgs, ... }:

{
  ##############################################
  # 🧩 Imports (Modular)
  ##############################################
  imports = [
    ../../modules/core
    ./boot.nix
    ./hardware.nix
    ./host-packages.nix
  ];

  networking.hostName = "nixos";

  services.printing.enable = true;

  ##############################################
  # 🔄 Auto Upgrade (flake based)
  ##############################################
  my.autoUpgrade = {
    enable = false;
    host = "nixos";
  };
}
