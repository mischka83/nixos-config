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
      xorg.libX11
      xorg.libXcomposite
      xorg.libXcursor
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXi
      xorg.libXrandr
      xorg.libXrender
      xorg.libXScrnSaver
      xorg.libXtst
      zlib
    ];

    runScript = "${rdmUnpacked}/usr/lib/devolutions/RemoteDesktopManager/RemoteDesktopManager";
  };

  rdmFhsLauncher = pkgs.writeShellScriptBin "remotedesktopmanager-fhs" ''
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
