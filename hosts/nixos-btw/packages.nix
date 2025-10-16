{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # --- System-Tools ---
    pciutils stow ffmpeg freshfetch nodejs clinfo tree

    # --- Productivity ---
    vscode libreoffice qownnotes

    # --- Communication ---
    discord teams-for-linux

    # --- Media ---
    vlc gimp-with-plugins

    # --- KDE-Apps ---
    kdePackages.kate kdePackages.dolphin kdePackages.konsole
    kdePackages.okular kdePackages.gwenview kdePackages.discover
    kdePackages.kcalc kdePackages.kdeconnect-kde
  ];

  programs = {
    firefox.enable = true;
    neovim.enable = true;
    steam.enable = true;
    git.enable = true;
  };

  fonts.packages = with pkgs.nerd-fonts; [
    droid-sans-mono symbols-only bigblue-terminal heavy-data hurmit
  ];

  # Flatpak (Flathub)
  services.flatpak.enable = true;

  environment.etc."flatpak/remotes.d/flathub.flatpakrepo".source = pkgs.fetchurl {
    url = "https://flathub.org/repo/flathub.flatpakrepo";
    sha256 = "0fm0zvlf4fipqfhazx3jdx1d8g0mvbpky1rh6riy3nb11qjxsw9k";
  };
}
