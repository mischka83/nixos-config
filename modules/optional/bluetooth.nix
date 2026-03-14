{ config, pkgs, ... }:

{
  # Enable Bluetooth hardware support
  hardware.bluetooth = {
    enable = true;

    # Automatically power on adapters when the system boots
    powerOnBoot = true;

    # Configure BlueZ daemon settings
    settings = {
      General = {
        # Show battery charge of connected Bluetooth devices
        # (supported adapters only)
        Experimental = true;

        # Allow other devices to connect faster at the cost of
        # increased power consumption
        FastConnectable = true;
      };

      Policy = {
        # Automatically enable all Bluetooth controllers/adapters
        AutoEnable = true;
      };
    };
  };

  # Note: KDE Plasma includes native Bluetooth support in System Settings.
  # If you prefer a dedicated GUI, you can add:
  #   environment.systemPackages = with pkgs; [ blueman ];
}
