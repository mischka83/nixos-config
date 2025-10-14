{
  description = "Mischkas NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # Falls du später Home Manager oder andere Inputs nutzt:
    # home-manager.url = "github:nix-community/home-manager/release-25.05";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
    };
  };
}
