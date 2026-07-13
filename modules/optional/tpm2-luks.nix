{ pkgs, ... }:

let
  luksDevice = "/dev/disk/by-uuid/fba69be1-8804-4ba3-8532-8f3b3d045425";
  reenrollLuksTpm2 = pkgs.writeShellScriptBin "reenroll-luks-tpm2" ''
    #!/usr/bin/env bash
    set -euo pipefail

    device="${1:-${luksDevice}}"
    pcrs="${2:-7}"

    if [[ "$EUID" -ne 0 ]]; then
      echo "Run as root, e.g. sudo reenroll-luks-tpm2"
      exit 1
    fi

    if [[ ! -e "$device" ]]; then
      echo "Device not found: $device"
      exit 1
    fi

    echo "Preparing TPM2 re-enrollment"
    echo "  Device: $device"
    echo "  PCR set: $pcrs"
    echo
    echo "Current TPM2 tokens (if any):"
    ${pkgs.cryptsetup}/bin/cryptsetup luksDump "$device" | ${pkgs.gnugrep}/bin/grep -A4 -E '^Tokens:|systemd-tpm2|Keyslot:' || true
    echo
    read -r -p "Continue with wiping TPM2 slot and re-enrolling? [y/N] " answer
    if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
      echo "Aborted."
      exit 0
    fi

    ${pkgs.systemd}/bin/systemd-cryptenroll --wipe-slot=tpm2 "$device"
    ${pkgs.systemd}/bin/systemd-cryptenroll --tpm2-device=auto --tpm2-pcrs="$pcrs" "$device"

    echo
    echo "Done. Updated token overview:"
    ${pkgs.cryptsetup}/bin/cryptsetup luksDump "$device" | ${pkgs.gnugrep}/bin/grep -A6 -E '^Tokens:|systemd-tpm2|Keyslot:' || true
    echo
    echo "Next step: reboot once to verify auto-unlock works."
  '';
in

{
  # TPM2-Based LUKS Disk Encryption for Lenovo Legion
  #
  # This module configures automatic LUKS decryption using TPM2 with
  # password fallback. The system will:
  # 1. Try to unseal the LUKS key from TPM2 at boot
  # 2. If TPM2 fails (e.g., tampered PCRs), fall back to password prompt
  #
  # REQUIREMENTS:
  # - TPM 2.0 hardware (your Lenovo Legion has this ✓)
  # - LUKS2 (your setup uses this ✓)
  # - Empty Keyslots/Tokens (your setup has space ✓)
  #
  # IMPORTANT: ONE-TIME SETUP
  # ─────────────────────────
  # The systemd-cryptenroll command is ONE-TIME ONLY and runs ONCE per system.
  # The TPM2 token is stored persistently on the LUKS2 partition itself,
  # NOT in the NixOS configuration. This means:
  #
  # ✅ After enrolling TPM2, it SURVIVES:
  #    - nixos-rebuild switch
  #    - nixos-rebuild boot
  #    - Kernel updates
  #    - Hardware changes (unless TPM is reset)
  #
  # ❌ You do NOT need to re-run cryptenroll after:
  #    - NixOS updates
  #    - Configuration changes
  #    - System rebuilds
  #
  # ⚠️  Special case - Firmware updates:
  #    After BIOS/firmware updates, PCRs might change and boot will ask for
  #    password (fallback). This is NORMAL and SAFE. Boot will work fine.
  #    IMPORTANT: fixed-PCR TPM policies do NOT auto-update after reboot.
  #    If this keeps happening, re-enroll the TPM2 token (see troubleshooting).
  #
  # SETUP INSTRUCTIONS (one-time, after first boot with this module):
  # ────────────────────────────────────────────────────────────────
  # 1. Enable this module and rebuild: nixos-rebuild switch --flake ~/nixos-config#nixos-btw
  #
  # 2. Reboot to activate TPM2 support: sudo reboot
  #
  # 3. After reboot, enroll your LUKS partition with TPM2 (ONE TIME):
  #    sudo systemd-cryptenroll \
  #      --tpm2-device=auto \
  #      --tpm2-pcrs=7 \
  #      ${luksDevice}
  #
  #    When prompted: Enter your current LUKS passphrase
  #    Expected output: "New TPM2 token enrolled as key slot 1."
  #
  # 4. Verify enrollment succeeded:
  #    sudo cryptsetup luksDump ${luksDevice}
  #    Should show "Tokens:" section with "0: systemd-tpm2" and "Keyslot: 1"
  #
  # 5. Reboot to test automatic TPM2 unsealing: sudo reboot
  #    Boot should NOT ask for password (TPM2 automatically unlocks)
  #
  # VERIFICATION:
  # ─────────────
  # Check if TPM2 key is enrolled:
  #   sudo cryptsetup luksDump ${luksDevice}
  #   Look for "Tokens:" section - should show TPM2 token
  #
  # Check TPM2 readiness:
  #   ls -la /dev/tpm*              # Should show /dev/tpm0 and /dev/tpmrm0
  #   lsmod | grep tpm              # Should show tpm_crb loaded
  #
  # TROUBLESHOOTING:
  # ────────────────
  # If boot asks for password after firmware update:
  #   1. This is NORMAL - PCR policy no longer matches measured values
  #   2. Enter your passphrase (fallback works perfectly)
  #   3. Re-enroll TPM2 policy from userspace using your chosen PCR set
  #
  # If boot asks for password and nothing changed:
  #   1. TPM might be reset, firmware updated, or PCR set too strict
  #   2. Re-enroll: sudo reenroll-luks-tpm2
  #   3. Then run the enrollment command again (step 3 above)
  #
  # If TPM2 unsealing fails:
  #   1. Try manual unlock: sudo /run/systemd/systemd-cryptsetup attach <name> <device>
  #   2. Check dmesg: sudo dmesg | grep -i tpm

  security.tpm2.enable = true;
  security.tpm2.pkcs11.enable = true;

  # Required for systemd-cryptsetup to work with TPM2
  boot.initrd.systemd.enable = true;

  # Optional: Enable TPM2 tools for debugging
  environment.systemPackages = with pkgs; [
    tpm2-tools
    reenrollLuksTpm2
  ];
}
