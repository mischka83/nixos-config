{ config, pkgs, ... }:
{
  # CPU Microcode
  hardware.cpu.amd.updateMicrocode = true;

  # Enable Firmware 
  hardware.enableAllFirmware = true;

  # Bluetooth
  bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}

