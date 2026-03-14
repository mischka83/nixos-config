# Audio aggregator - combines all audio-related modules

{ ... }:

{
  imports = [
    ./pipewire.nix
    ./rtkit.nix
  ];
}
