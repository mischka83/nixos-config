{ config, pkgs, ... }:

{

  hardware ={
    # CPU Microcode
    cpu.amd.updateMicrocode = true;
    # Enable Firmware 
    enableAllFirmware = true;
    # Bluetooth
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

}

