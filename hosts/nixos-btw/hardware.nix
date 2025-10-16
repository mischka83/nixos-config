{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_6_1;
  boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ];
  boot.blacklistedKernelModules = [ "elan_i2c" ];

  # Firmware & SSD
  services.fwupd.enable = true;
  services.fstrim.enable = true;

  # CPU Microcode
  hardware.cpu.amd.updateMicrocode = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Optional: andere Hardware-spezifische Einstellungen
}
