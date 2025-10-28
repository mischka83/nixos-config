{ config, pkgs, ... }:

{

  boot = {
    # Kernel
    kernelPackages = pkgs.linuxPackages_6_17;
    kernelParams = [ "psmouse.synaptics_intertouch=0" ];
    blacklistedKernelModules = [ "elan_i2c" ];
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };
}