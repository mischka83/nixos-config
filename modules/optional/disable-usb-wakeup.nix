{ pkgs, ... }:

{
  # Reduce spurious wakeups from USB host controllers while suspended.
  systemd.services.disable-usb-wakeup = {
    description = "Disable USB wakeup sources (XHC0/XHC1 + AMD USB controllers)";
    wantedBy = [ "multi-user.target" ];
    after = [ "sysinit.target" ];
    serviceConfig = {
      Type = "oneshot";
    };
    script = ''
      set -eu

      toggle_acpi_wakeup() {
        local node="$1"
        if ${pkgs.gnugrep}/bin/grep -qE "^${node}[[:space:]].*\*enabled" /proc/acpi/wakeup; then
          echo "$node" > /proc/acpi/wakeup
        fi
      }

      disable_sysfs_wakeup() {
        local path="$1"
        if [ -w "$path" ]; then
          echo disabled > "$path"
        fi
      }

      # ACPI aliases for USB wake on this platform.
      toggle_acpi_wakeup XHC0
      toggle_acpi_wakeup XHC1

      # USB controllers shown as wake-enabled in runtime checks.
      disable_sysfs_wakeup /sys/bus/pci/devices/0000:06:00.3/power/wakeup
      disable_sysfs_wakeup /sys/bus/pci/devices/0000:06:00.4/power/wakeup
    '';
  };
}
