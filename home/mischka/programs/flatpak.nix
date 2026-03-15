{ pkgs, ... }:

{
  # Ensure user-level Flathub and Devolutions RDM are present.
  # The commands are idempotent and safe to run repeatedly.
  systemd.user.services.flatpak-rdm = {
    Unit = {
      Description = "Install Devolutions RDM Flatpak for user";
      After = [ "default.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = [
        "${pkgs.flatpak}/bin/flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo"
        "${pkgs.flatpak}/bin/flatpak --user install -y --noninteractive flathub net.devolutions.RDM"
      ];
    };

    Install.WantedBy = [ "default.target" ];
  };
}
