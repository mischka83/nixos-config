# Optional module: Devolutions Remote Desktop Manager in an FHS sandbox
#
# Purpose:
# - Run the upstream proprietary RDM .deb package on NixOS without patching the
#   vendor binary directly.
# - Keep this integration isolated as a test module that can be enabled/disabled
#   via host imports.
#
# What this module provides:
# - Downloads and unpacks a pinned RDM .deb version.
# - Wraps the app in buildFHSEnv with required runtime libraries.
# - Provides launcher command: remotedesktopmanager-fhs
# - Installs a desktop entry: "Remote Desktop Manager (FHS Test)"
#
# Activation:
# - Import this module in hosts/<host>/default.nix.
# - Rebuild: sudo nixos-rebuild switch --flake .#<host>
#
# Rollback:
# - Remove the module import from the host config and rebuild.

{ pkgs, ... }:

let
  version = "2026.2.0.7";

  rdmDeb = pkgs.fetchurl {
    url = "https://cdn.devolutions.net/download/Linux/RDM/${version}/RemoteDesktopManager_${version}_amd64.deb";
    sha256 = "118f708430e84340cb111ed17f4c722ebe3ae0f07b074ed9ef1d5fd4608174ec";
  };

  rdmUnpacked = pkgs.stdenvNoCC.mkDerivation {
    pname = "remotedesktopmanager-unpacked";
    inherit version;
    src = rdmDeb;

    nativeBuildInputs = [ pkgs.dpkg ];

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p "$out"
      dpkg-deb -x "$src" "$out"

      runHook postInstall
    '';
  };

  rdmFhsEnv = pkgs.buildFHSEnv {
    name = "rdm-fhs";

    targetPkgs = pkgs: with pkgs; [
      alsa-lib
      at-spi2-atk
      at-spi2-core
      cairo
      cups
      dbus
      expat
      fontconfig
      freetype
      gdk-pixbuf
      glib
      gtk3
      icu
      krb5
      libdrm
      libpulseaudio
      libsecret
      libusb1
      libxkbcommon
      mesa
      nspr
      nss
      openssl
      pango
      glib-networking
      libsoup_3
      stdenv.cc.cc.lib
      udev
      wayland
      webkitgtk_4_1
      xdotool
      libX11
      libICE
      libSM
      libXcomposite
      libXcursor
      libXdamage
      libXext
      libXfixes
      libXi
      libXrandr
      libXrender
      libXScrnSaver
      libXtst
      gst_all_1.gstreamer
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-good
      zlib
    ];

    runScript = "${rdmUnpacked}/usr/lib/devolutions/RemoteDesktopManager/RemoteDesktopManager";
  };

  rdmFhsLauncher = pkgs.writeShellScriptBin "remotedesktopmanager-fhs" ''
    rdm_xdg_config_home="''${XDG_CONFIG_HOME:-$HOME/.config}/rdm-fhs"
    rdm_xdg_data_home="''${XDG_DATA_HOME:-$HOME/.local/share}/rdm-fhs"
    rdm_xdg_cache_home="''${XDG_CACHE_HOME:-$HOME/.cache}/rdm-fhs"

    mkdir -p "$rdm_xdg_config_home/gtk-3.0" "$rdm_xdg_data_home" "$rdm_xdg_cache_home"

    # Prevent host KDE GTK modules (colorreload/appmenu) from being injected.
    cat > "$rdm_xdg_config_home/gtk-3.0/settings.ini" <<'EOF'
[Settings]
gtk-application-prefer-dark-theme=true
EOF

    export XDG_CONFIG_HOME="$rdm_xdg_config_home"
    export XDG_DATA_HOME="$rdm_xdg_data_home"
    export XDG_CACHE_HOME="$rdm_xdg_cache_home"

    export GTK_PATH=""
    export GTK_MODULES=""
    unset GTK3_MODULES

    export DOTNET_EnableWriteXorExecute=0
    # Avalonia backend in RDM currently requires X11 in this FHS setup.
    # Allow user/session override by honoring an explicitly set GDK_BACKEND.
    export GDK_BACKEND="''${GDK_BACKEND:-x11}"

    # Mitigate WebKitGTK GPU/DMABUF regressions seen on some driver stacks.
    export WEBKIT_DISABLE_DMABUF_RENDERER=1
    export WEBKIT_DISABLE_COMPOSITING_MODE=1

    # Keep runtime dir sane even when launched from unusual sessions.
    if [[ -z "''${XDG_RUNTIME_DIR:-}" ]]; then
      export XDG_RUNTIME_DIR="/run/user/$(id -u)"
    fi

    exec "${rdmFhsEnv}/bin/rdm-fhs" "$@"
  '';

  rdmDesktopItem = pkgs.makeDesktopItem {
    name = "remotedesktopmanager-fhs";
    desktopName = "Remote Desktop Manager (FHS Test)";
    comment = "Proprietary DEB app in a local FHS sandbox";
    exec = "remotedesktopmanager-fhs %U";
    icon = "remotedesktopmanager-fhs";
    terminal = false;
    type = "Application";
    categories = [ "Network" "RemoteAccess" ];
  };

  rdmIconTheme = pkgs.runCommand "remotedesktopmanager-fhs-icon" { } ''
    mkdir -p "$out/share/icons/hicolor/256x256/apps"

    # Prefer the vendor icon from the unpacked .deb payload.
    for candidate in \
      "${rdmUnpacked}/usr/share/icons/hicolor/256x256/apps/remotedesktopmanager.png" \
      "${rdmUnpacked}/usr/share/pixmaps/remotedesktopmanager.png" \
      "${rdmUnpacked}/usr/share/icons/hicolor/512x512/apps/remotedesktopmanager.png"
    do
      if [[ -f "$candidate" ]]; then
        cp "$candidate" "$out/share/icons/hicolor/256x256/apps/remotedesktopmanager-fhs.png"
        exit 0
      fi
    done

    # Fallback icon so launchers never show a blank icon tile.
    cp "${pkgs.nixos-icons}/share/icons/hicolor/256x256/apps/nix-snowflake.png" \
      "$out/share/icons/hicolor/256x256/apps/remotedesktopmanager-fhs.png"
  '';

  rdmFhsPackage = pkgs.symlinkJoin {
    name = "remotedesktopmanager-fhs-test";
    paths = [
      rdmFhsLauncher
      rdmDesktopItem
      rdmIconTheme
    ];
  };
in
{
  # Optional test module: run Devolutions RDM DEB inside an FHS env.
  # Rollback is one-line: remove this module import from the host config.
  environment.systemPackages = [
    rdmFhsPackage
  ];
}
