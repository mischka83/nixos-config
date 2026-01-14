{
  description = "Mischkas NixOS configuration (KDE Plasma 6)";

  inputs = {
    # --- NixOS Packages ---
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    # --- Hardware Profile (z. B. für Lenovo Legion) ---
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # 
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    # --- Home Manager hinzufügen (zur NixOS-Version passend)
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # --- Hyperland Window Manager (optional) ---
    hyprland.url = "github:hyprwm/Hyprland";
    
  };

  outputs = { self, nixpkgs, nixos-hardware, plasma-manager, nix-flatpak, ... }@inputs: {
    nixosConfigurations = {
      nixos-btw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          # Hardware-Unterstützung für dein Lenovo Legion
          nixos-hardware.nixosModules.lenovo-legion-16achg6-hybrid

          # Deine Hauptsystemkonfiguration
          ./hosts/nixos-btw/default.nix

          nix-flatpak.nixosModules.nix-flatpak

          # Optional: Home Manager aktivieren
          inputs.home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.mischka = {
              imports = [
                ./home/mischka/home.nix
                plasma-manager.homeModules.plasma-manager
              ];
            };
            home-manager.backupFileExtension = "backup";
          }
        ];

        # Spezialargumente, falls du Inputs in der config brauchst
        specialArgs = { inherit inputs; };
      };
    };
  };
}
