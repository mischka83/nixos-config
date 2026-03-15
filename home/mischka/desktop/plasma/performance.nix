{ ... }:

{
  programs.plasma.kwin.effects = {
    # Blur-Effekt
    blur = {
      enable = true;
      strength = 5;        # Intensität des Blur (1–15)
      noiseStrength = 8;   # Rauschstärke (0–14)
    };

    # Translucency
    translucency = {
      enable = true;
    };

    # Minimization
    minimization = {
      animation = "off";   # "squash", "magiclamp" oder "off"
      duration = null;        # Dauer nur relevant bei "magiclamp"
    };

    # Wobbly Windows
    wobblyWindows = {
      enable = false;
    };

    # Desktop Switching
    desktopSwitching = {
      animation = "fade";   # "fade", "slide", "off"
      navigationWrapping = true;
    };

    # FPS-Anzeige
    fps = {
      enable = false;
    };

    # Cube
    cube = {
      enable = false;
    };

    # Snap Helper (visuelle Hilfe beim Andocken)
    snapHelper = {
      enable = true;
    };

    # Zoom
    zoom = {
      enable = false;
      zoomFactor = 1.2;
      pixelGridZoom = 15.0;
      mousePointer = "scale";       # "scale", "keep", "hide"
      mouseTracking = "proportional"; # "proportional", "centered", "push", "disabled"
      focusTracking = { enable = false; };
      textCursorTracking = { enable = false; };
      scrollGestureModKeys = "Meta+Ctrl";
    };

    # Magnifier
    magnifier = {
      enable = false;
      height = 200;
      width = 200;
    };

    # Optional weitere Effekte
    shakeCursor = { enable = false; };
    fallApart = { enable = false; };
    dimInactive = { enable = false; };
    dimAdminMode = { enable = false; };
    slideBack = { enable = false; };
  };

  # Compositor-Einstellungen zur Reduzierung von Eingabeverzögerung und Maus-Rucklern.
  # LatencyPolicy=extreme: minimiert die Zeit zwischen Eingabe und Darstellung.
  # WindowsBlockCompositing=false: verhindert, dass Anwendungen den Compositor
  #   deaktivieren – das vermeidet Ruckler beim Fokus-Wechsel zurück auf den Desktop.
  programs.plasma.configFile."kwinrc"."Compositing" = {
    LatencyPolicy            = "extreme";
    WindowsBlockCompositing  = false;
  };
}
