{
  description = "Mischkas NixOS configuration (KDE Plasma 6)";

  inputs = {
    # --- NixOS Packages ---
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # --- Hardware Profile (z. B. für Lenovo Legion) ---
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # --- Optional: Home Manager (kann später aktiviert werden) ---
    # home-manager = {
    #   url = "github:nix-community/home-manager/release-25.05";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }@inputs: {
    nixosConfigurations = {
      nixos-btw = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          # Hardware-Unterstützung für dein Lenovo Legion
          nixos-hardware.nixosModules.lenovo-legion-16achg6-hybrid

          # Deine Hauptsystemkonfiguration
          ./hosts/nixos-btw/configuration.nix
          
          # Optional: Home Manager aktivieren
          inputs.home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mischka = import ./home/mischka/home.nix;
          }
        ];

        # Spezialargumente, falls du Inputs in der config brauchst
        specialArgs = { inherit inputs; };
      };
    };
  };
}
