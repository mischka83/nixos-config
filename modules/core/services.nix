{ config, pkgs, ... }:

{
  ##############################################
  # 🔹 Core Services (unabhängig von DE/WM)
  ##############################################
  services = {
    # Firmware & SSD Maintenance
    fwupd.enable = true;
    fstrim.enable = true;

    # Audio / Pipewire
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true; # moderner Session-Manager
    };

    # Pulseaudio deaktivieren
    pulseaudio.enable = false;

    # Input Devices
    libinput.enable = true;
  };
}
