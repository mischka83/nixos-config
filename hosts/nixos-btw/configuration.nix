{ config, pkgs, inputs, ... }:

{
  ##############################################
  # 🧩 Imports
  ##############################################
  imports = [
    ../../hardware-configuration.nix
  ];

  ##############################################
  # 🌍 System Basics
  ##############################################
  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Berlin";

  i18n = {
    defaultLocale = "de_DE.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };

  ##############################################
  # ⚙️ Nix & System Maintenance
  ##############################################
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 20d";
    };

    optimise.automatic = true;
  };

  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    flake = "/home/mischka/nixos-config#nixos-btw"; # Pfad an Flake-Struktur angepasst
    dates = "daily";
  };
  
  ##############################################
  # 🔄 Automatische tägliche Systemupdates
  ##############################################
  systemd.services."nixos-auto-upgrade" = {
    description = "Automatic daily NixOS upgrade via flakes";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        /run/current-system/sw/bin/nix flake update /home/mischka/nixos-config
        /run/current-system/sw/bin/nixos-rebuild switch --flake /home/mischka/nixos-config#nixos-btw
      '';
      # Optional: Log in /var/log/nixos-auto-upgrade.log schreiben
      StandardOutput = "journal";
      StandardError = "journal";
    };
  };

  systemd.timers."nixos-auto-upgrade" = {
    description = "Run nixos-auto-upgrade daily";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      RandomizedDelaySec = "1h"; # kleine zufällige Verzögerung zur Entlastung von nixpkgs-Servern
    };
  };

  ##############################################
  # 🧠 Bootloader & Kernel
  ##############################################
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Verwende stabilen Kernel (6.1)
  boot.kernelPackages = pkgs.linuxPackages_6_1;
  boot.kernelParams = [ "psmouse.synaptics_intertouch=0" ];
  boot.blacklistedKernelModules = [ "elan_i2c" ];

  ##############################################
  # 🖥️ Desktop Environment: KDE Plasma 6
  ##############################################
  services.xserver.enable = true;

  # Display Manager (Login)
  services.xserver.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # KDE Plasma aktivieren
  services.xserver.desktopManager.plasma6.enable = true;

  # Tastatur-Layouts
  services.xserver.xkb.layout = "de";
  console.keyMap = "de";

  ##############################################
  # 🔊 Audio & Multimedia
  ##############################################
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true; # moderner Session-Manager
  };

  ##############################################
  # 🖨️ Hardware & Peripherals
  ##############################################
  services.printing.enable = true;      # Drucker
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.fwupd.enable = true;         # Firmware Updates
  services.fstrim.enable = true;        # SSD Trim
  hardware.cpu.amd.updateMicrocode = true;

  ##############################################
  # 🧑‍💻 Benutzer & Rechte
  ##############################################
  users.users.mischka = {
    isNormalUser = true;
    description = "Christian Ewert";
    extraGroups = [ "networkmanager" "wheel" ]; # 'wheel' = sudo-Rechte
    packages = with pkgs; [ ];
  };

  ##############################################
  # 💾 Package Management
  ##############################################
  nixpkgs.config.allowUnfree = true;

  # Systemweite Programme
  environment.systemPackages = with pkgs; [
    # --- System-Tools ---
    pciutils
    stow
    ffmpeg
    freshfetch
    nodejs
    clinfo

    # --- Productivity ---
    vscode
    libreoffice
    qownnotes

    # --- Communication ---
    discord
    teams-for-linux

    # --- Media ---
    vlc
    gimp-with-plugins

    # --- KDE-Apps ---
    kdePackages.kate
    kdePackages.dolphin
    kdePackages.konsole
    kdePackages.okular
    kdePackages.gwenview
    kdePackages.discover
    kdePackages.kcalc
    kdePackages.kdeconnect-kde
  ];

  # Program-Module aktivieren
  programs = {
    firefox.enable = true;
    neovim.enable = true;
    steam.enable = true;
    git.enable = true;
  };

  ##############################################
  # 🧱 Fonts
  ##############################################
  fonts.packages = with pkgs.nerd-fonts; [
    droid-sans-mono
    symbols-only
    bigblue-terminal
    heavy-data
    hurmit
  ];

  ##############################################
  # 📦 Flatpak (Flathub)
  ##############################################
  services.flatpak.enable = true;

  environment.etc."flatpak/remotes.d/flathub.flatpakrepo".source = pkgs.fetchurl {
    url = "https://flathub.org/repo/flathub.flatpakrepo";
    sha256 = "0fm0zvlf4fipqfhazx3jdx1d8g0mvbpky1rh6riy3nb11qjxsw9k";
  };

  ##############################################
  # 🔐 Firewall & Netzwerk (optional)
  ##############################################
  # networking.firewall.enable = false;
  # services.openssh.enable = true;

  ##############################################
  # 🧩 System Version
  ##############################################
  system.stateVersion = "25.05";
}