{ lib, ... }:

{
  imports = [
    ./plasma/default.nix
    ./wayland/default.nix

    # Backward-compatible option rename to keep existing configs working.
    (lib.mkRenamedOptionModule [ "profile" "desktop" "niri" "enable" ] [ "profile" "desktop" "wayland" "niri" "enable" ])
  ];
}
