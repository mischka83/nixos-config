{ lib, pkgs, ... }:

let
  hyprlandPkg = pkgs.hyprland;
in

{
  # Work around current Hyprland build failure where CMake FetchContent
  # cannot find git while resolving the glaze dependency.
  nixpkgs.overlays = [
    (final: prev: {
      hyprland = prev.hyprland.overrideAttrs (old: {
        postPatch = (old.postPatch or "") + ''
          if grep -Fq 'find_package(glaze 7...<8 QUIET)' CMakeLists.txt; then
            substituteInPlace CMakeLists.txt \
              --replace 'find_package(glaze 7...<8 QUIET)' 'find_package(glaze QUIET)'
          fi
        '';
      });
    })
  ];

  # Add Hyprland as an additional Wayland session in SDDM.
  programs.hyprland = {
    enable = true;
    package = hyprlandPkg;
    xwayland.enable = true;
  };

  # Keep Plasma as default login session while exposing Niri + Hyprland.
  services.displayManager.defaultSession = lib.mkForce "plasma";
}
