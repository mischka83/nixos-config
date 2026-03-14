{ config, lib, pkgs, ... }:

{
  config = {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nixpkgs.config.allowUnfree = true;
  };
}
