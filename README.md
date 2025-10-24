# nixos-config

Personal NixOS / home-manager configuration repository for the user environment.

Overview
- Centralised configuration for user packages, shells and editor settings.
- home/mischka/home.nix imports modular pieces: `user.nix`, `zsh.nix`, `vscode.nix`, `dotfiles.nix`.
- Configuration declares common productivity, media, communication, CLI and development packages.

Notable packages declared in home.nix
- Productivity: libreoffice, drawio, qownnotes, thunderbird, stirling-pdf, bitwarden-desktop
- Media: vlc, gimp-with-plugins, parabolic, delfin
- Communication: ferdium, teams-for-linux
- CLI tools: htop, bat, neofetch, freshfetch, ripgrep, fd, wget, kitty, imagemagick
- File management: unzip, unrar
- Development: powershell, gcc, lazygit

Repository layout (example)
- flake.nix or default.nix — flake entrypoint (optional)
- home/mischka/home.nix — main per-user home-manager configuration
- ./user.nix, ./zsh.nix, ./vscode.nix, ./dotfiles.nix — modular imports

Usage
- If using flakes:
  - Apply system (NixOS): sudo nixos-rebuild switch --flake .#<hostname>
  - Apply user (home-manager): home-manager switch --flake .#<username>
- If not using flakes:
  - Use `home-manager switch -f path/to/home.nix` or include files in the system configuration as appropriate.

Contributing
- Open an issue or submit a pull request with proposed changes.
- Keep changes modular and document any added packages or options.

License
- Default: MIT (adjust as needed).