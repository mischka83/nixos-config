{ config, pkgs, ... }:

{
imports = [
    ./system.nix
    ./services.nix
    ./user.nix
  ];

}