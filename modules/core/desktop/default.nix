{ ... }:

{
  imports = [
    ./xserver.nix
    ./displaymanager.nix
    ./plasma.nix
    ./sddm-silent.nix
  ];
}
