{ config, pkgs, ... }:

{
imports = [
    ./system.nix
    ./security.nix
    ./services.nix
    ./user.nix
  ];

}