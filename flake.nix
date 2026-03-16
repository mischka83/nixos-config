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

    # Secure Boot (optional) via Lanzaboote
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Plasma Manager - für KDE Plasma Customization
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # SilentSDDM – Plasma-6-kompatibles SDDM-Theme
    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NUR - Nix User Repository (für Firefox-Extensions u.a.)
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, nixos-hardware, ... }:
    let
      mkHome = { username, homeModule }: {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users.${username} = {
          imports = [
            inputs.plasma-manager.homeModules.plasma-manager
            homeModule
          ];
        };
        home-manager.backupFileExtension = "hm-backup";
      };

      mkHost = {
        hostModule,
        username,
        homeModule,
        system ? "x86_64-linux",
        extraModules ? [ ],
      }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules =
            extraModules
            ++ [
              { nixpkgs.overlays = [ inputs.nur.overlays.default ]; }
              inputs.silentSDDM.nixosModules.default
              hostModule
              home-manager.nixosModules.home-manager
              (mkHome {
                inherit username homeModule;
              })
            ];
        };
    in
    {
      nixosConfigurations.nixos-btw = mkHost {
        hostModule = ./hosts/nixos-btw/default.nix;
        username = "mischka";
        homeModule = ./home/mischka/default.nix;
        extraModules = [
          # add your model from this list: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
          nixos-hardware.nixosModules.lenovo-legion-16achg6-hybrid
        ];
      };
    };
}
