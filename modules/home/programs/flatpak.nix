{ pkgs, ... }:

{
  # Install user-level Flatpaks once, then skip future logins.
  # Bump the marker suffix to re-run when the app set changes.
  systemd.user.services.flatpak-bootstrap = {
    Unit = {
      Description = "Bootstrap required user Flatpaks once";
      After = [ "default.target" ];
      ConditionPathExists = "!%h/.local/state/flatpak-bootstrap-v1.done";
    };

    Service = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "flatpak-bootstrap" ''
        set -euo pipefail

        ${pkgs.flatpak}/bin/flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        ${pkgs.flatpak}/bin/flatpak --user install -y --noninteractive flathub net.devolutions.RDM
        ${pkgs.flatpak}/bin/flatpak --user install -y --noninteractive flathub com.github.IsmaelMartinez.teams_for_linux
        ${pkgs.flatpak}/bin/flatpak --user install -y --noninteractive flathub org.jellyfin.JellyfinDesktop
        ${pkgs.flatpak}/bin/flatpak --user install -y --noninteractive flathub com.bitwarden.desktop

        mkdir -p "$HOME/.local/state"
        : > "$HOME/.local/state/flatpak-bootstrap-v1.done"
      '';
    };

    Install.WantedBy = [ "default.target" ];
  };
}
