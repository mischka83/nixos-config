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
      stdenv.cc.cc.lib
      udev
      wayland
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
    export GDK_BACKEND=x11

    exec "${rdmFhsEnv}/bin/rdm-fhs" "$@"
  '';

  rdmDesktopItem = pkgs.makeDesktopItem {
    name = "remotedesktopmanager-fhs";
    desktopName = "Remote Desktop Manager (FHS Test)";
    comment = "Proprietary DEB app in a local FHS sandbox";
    exec = "remotedesktopmanager-fhs %U";
    terminal = false;
    type = "Application";
    categories = [ "Network" "RemoteAccess" ];
  };

  rdmFhsPackage = pkgs.symlinkJoin {
    name = "remotedesktopmanager-fhs-test";
    paths = [
      rdmFhsLauncher
      rdmDesktopItem
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
