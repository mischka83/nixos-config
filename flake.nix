{
  description = "Mischkas NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, nixos-hardware, nix-flatpak, plasma-manager, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";

    # ⭐ Default Host
    defaultHost = "nixos-btw";

    # ⭐ Versions zentral importieren
    versions = import ./lib/versions.nix;

    # ⭐ User Definitionen zentral importieren
    users = import ./lib/users.nix;

    # kleine Factory
    mkHost = { hostName, extraModules ? [ ], hardwareModules ? [ ] }:
      nixpkgs.lib.nixosSystem {
        inherit system;

        # Spezialargumente: Inputs + hostName + versions
        specialArgs = {
          inherit inputs hostName versions users;
        };

        modules =
          hardwareModules ++
          [
            # Host-spezifische Default Config
            ./hosts/${hostName}/default.nix

            # Flatpak
            nix-flatpak.nixosModules.nix-flatpak

            # Home Manager
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs hostName versions users; };
              home-manager.users.${users.defaultUser.name} = {
                imports = [
                  ./home/${users.defaultUser.name}/home.nix
                  plasma-manager.homeModules.plasma-manager
                ];
              };

              home-manager.backupFileExtension = "backup";
            }
          ]
          ++ extraModules;
      };
  in
  {
    nixosConfigurations = {
      nixos-btw = mkHost {
        hostName = "nixos-btw";
        hardwareModules = [
          nixos-hardware.nixosModules.lenovo-legion-16achg6-hybrid
        ];
      };

      nixos = mkHost {
        hostName = "nixos";
      };
    };

    # ⭐ erlaubt: nixos-rebuild switch --flake .
    defaultPackage.${system} =
      self.nixosConfigurations.${defaultHost}.config.system.build.toplevel;
  };
}
