{ pkgs, ... }:

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
  #    After a few reboots, systemd will re-measure and cache the new PCRs.
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
  #      --tpm2-pcrs=0,1,3,7 \
  #      --tpm2-public-key-pcrs=0,1,3,7 \
  #      /dev/disk/by-uuid/fba69be1-8804-4ba3-8532-8f3b3d045425
  #
  #    When prompted: Enter your current LUKS passphrase
  #    Expected output: "New TPM2 token enrolled as key slot 1."
  #
  # 4. Verify enrollment succeeded:
  #    sudo cryptsetup luksDump /dev/disk/by-uuid/fba69be1-8804-4ba3-8532-8f3b3d045425
  #    Should show "Tokens:" section with "0: systemd-tpm2" and "Keyslot: 1"
  #
  # 5. Reboot to test automatic TPM2 unsealing: sudo reboot
  #    Boot should NOT ask for password (TPM2 automatically unlocks)
  #
  # VERIFICATION:
  # ─────────────
  # Check if TPM2 key is enrolled:
  #   sudo cryptsetup luksDump /dev/disk/by-uuid/fba69be1-8804-4ba3-8532-8f3b3d045425
  #   Look for "Tokens:" section - should show TPM2 token
  #
  # Check TPM2 readiness:
  #   ls -la /dev/tpm*              # Should show /dev/tpm0 and /dev/tpmrm0
  #   lsmod | grep tpm              # Should show tpm_crb loaded
  #
  # TROUBLESHOOTING:
  # ────────────────
  # If boot asks for password after firmware update:
  #   1. This is NORMAL - PCRs changed, systemd will re-measure on next boots
  #   2. Enter your passphrase (fallback works perfectly)
  #   3. After 1-2 reboots, TPM2 unsealing should resume automatically
  #
  # If boot asks for password and nothing changed:
  #   1. TPM might be tampered or reset
  #   2. Re-enroll: sudo systemd-cryptenroll --tpm2-device=auto --wipe-slot=tpm2 /dev/disk/by-uuid/fba69be1-8804-4ba3-8532-8f3b3d045425
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
  ];
}
