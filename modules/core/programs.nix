{ ... }:

{
  # Browser packages are selected in Home Manager via modules/home/programs/browser.nix.
  # Keep system-level Firefox disabled to avoid having both Firefox and Chrome installed.
  programs.firefox.enable = true;
}
