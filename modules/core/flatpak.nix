{ pkgs, ... }: 

{

  # Flatpak Configuration
  services = {
    flatpak = {
      enable = true;
      packages = [
        "com.github.tchx84.Flatseal"              # Manage flatpak permissions - should always have this
        #"com.rtosta.zapzap"                      # WhatsApp client
        "io.github.flattool.Warehouse"            # Manage flatpaks, clean data, remove flatpaks and deps
        #"it.mijorus.gearlever"                   # Manage and support AppImages
        #"io.github.freedoom.Phase1"              # Classic Doom FPS 1
        #"io.github.freedoom.Phase2"              # Classic Doom FPS 2
        #"io.github.dvlv.boxbuddyrs"              # Manage distroboxes
        "de.schmidhuberj.tubefeeder"              # watch YT videos
        "com.devolutions.remotedesktopmanager"    # Remote Desktop Manager
        "io.github.freedoom.Phase1"               # Classic Doom FPS 1
        "com.brave.Browser"                       # Brave Browser
        "org.DolphinEmu.dolphin-emu"              # Dolphin Emulator for GameCube/Wii
        "org.ppsspp.PPSSPP"                       # PSP Emulator
        # Add other Flatpak IDs here, e.g., "org.mozilla.firefox"
      ];
      update.onActivation = true;
    };

  };

}