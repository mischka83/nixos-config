{ ... }:

{
  imports = [
    ./xserver.nix
    ./displaymanager.nix
    ./plasma.nix
    # Temporarily disabled while diagnosing missing login screen on boot.
    # Re-enable once greeter stability is confirmed.
    # ./sddm-silent.nix
  ];
}
