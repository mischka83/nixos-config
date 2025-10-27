{ config, pkgs, ... }:

{
imports = [
    ./network.nix
    ./sddm.nix
    ./security.nix
    ./services.nix
    ./system.nix
    ./xserver.nix
  ];

}