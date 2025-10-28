{ pkgs, ... }: {

  # Flatpak Configuration
  services = {
    flatpak.enable = true;
    environment.etc."flatpak/remotes.d/flathub.flatpakrepo".source = pkgs.fetchurl {
      url = "https://flathub.org/repo/flathub.flatpakrepo";
      sha256 = "0fm0zvlf4fipqfhazx3jdx1d8g0mvbpky1rh6riy3nb11qjxsw9k";
    };
    packages = [
      #"com.github.tchx84.Flatseal" #Manage flatpak permissions - should always have this
      #"com.rtosta.zapzap"              # WhatsApp client
      #"io.github.flattool.Warehouse"   # Manage flatpaks, clean data, remove flatpaks and deps
      #"it.mijorus.gearlever"           # Manage and support AppImages
      #"io.github.freedoom.Phase1"      #  Classic Doom FPS 1
      #"io.github.freedoom.Phase2"      #  Classic Doom FPS 2
      #"io.github.dvlv.boxbuddyrs"      #  Manage distroboxes
      #"de.schmidhuberj.tubefeeder"     #watch YT videos

      # Add other Flatpak IDs here, e.g., "org.mozilla.firefox"
    ];
    update.onActivation = true;
  }

}