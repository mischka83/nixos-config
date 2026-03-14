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
  # SETUP INSTRUCTIONS (after first boot):
  # ────────────────────────────────────
  # 1. Rebuild NixOS with this module enabled
  #
  # 2. Enroll your LUKS partition with TPM2:
  #    sudo systemd-cryptenroll \
  #      --tpm2-device=auto \
  #      --tpm2-pcrs=0,1,3,7 \
  #      --tpm2-public-key-pcrs=0,1,3,7 \
  #      /dev/disk/by-uuid/fba69be1-8804-4ba3-8532-8f3b3d045425
  #
  # 3. Reboot and you should boot WITHOUT password prompt
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
  # If boot still asks for password:
  #   1. PCRs might have changed (common with firmware updates)
  #   2. Check: sudo systemd-cryptenroll --tpm2-device=auto --wipe-slot=tpm2 <device>
  #   3. Then re-enroll with the command above
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
