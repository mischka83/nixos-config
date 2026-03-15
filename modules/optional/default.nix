# Optional modules - not imported by default
#
# These modules provide additional functionality that is not essential to all
# hosts. Import them explicitly in your host configuration if needed.
#
# Examples:
# - Bluetooth support (for laptops with Bluetooth hardware)
# - Virtualization (QEMU/KVM for development)
# - Gaming (Steam, Proton, etc.) via subfolders like ./gaming/
#
# Usage in host config:
#   imports = [
#     ../../modules/core/default.nix
#     ../../modules/optional/bluetooth.nix
#     ../../modules/optional/gaming/default.nix
#   ];

{ ... }:

{
  # This is a placeholder. Optional modules are imported individually in host configs,
  # not through this aggregator (unlike modules/core).
}
