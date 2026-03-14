{
  description = "Mischkas NixOS configuration with flakes";

  inputs = {
    # Offizielle NixOS Paketquelle (unstable oder stable)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # NixOS Hardware Configuration
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home-Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }@inputs: {
    nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # add your model from this list: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
        nixos-hardware.nixosModules.lenovo-legion-16achg6-hybrid
        ./hosts/nixos-btw/default.nix

        # Home-Manager als Modul einbinden
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.mischka = import ./home/mischka/default.nix;
        }
      ];
    };
  };
}
