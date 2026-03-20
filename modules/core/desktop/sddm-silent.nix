{ inputs, ... }:

{
  # SilentSDDM – Plasma-6-kompatibles SDDM-Theme
  # Modulquelle: github:uiriansan/SilentSDDM
  # Das Modul setzt automatisch: theme, extraPackages, qtvirtualkeyboard-Umgebung.
  imports = [ inputs.silentSDDM.nixosModules.default ];

  programs.silentSDDM = {
    enable = true;

    # Verfuegbare Presets: rei, ken, silvia, everforest,
    # catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha, nord
    theme = "default";

    # Optionale Theme-Anpassungen (>200 Optionen auf der Wiki-Seite):
    # https://github.com/uiriansan/SilentSDDM/wiki/Options
    settings = {
      "LoginScreen.LoginArea.Avatar" = {
        shape = "circle";
      };
      "LoginScreen" = {
        background = "smoky.jpg";
      };
      "LockScreen" = {
        background = "smoky.jpg";
      };
    };
  };
}
