# Core modules aggregator
# Imports all core system modules in logical groups

{ ... }:

{
  imports = [
    # Core system configuration
    ./boot.nix
    ./networking.nix
    ./localization.nix
    ./nix.nix
    ./system-packages.nix
    ./programs.nix
    ./users.nix

    # Desktop environment (aggregated)
    ./desktop/default.nix

    # Audio stack (aggregated)
    ./audio/default.nix

    # Additional services (aggregated)
    ./services/default.nix
  ];
}
