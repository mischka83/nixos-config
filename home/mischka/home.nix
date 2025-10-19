{ config, pkgs, inputs, ... }:

{
  home.username = "mischka";
  home.homeDirectory = "/home/mischka";
  home.stateVersion = "25.05"; # Wichtig! Entspricht NixOS Version

  # Git nur für diesen Benutzer
  programs.git = {
    enable = true;
    userName = "Christian Ewert";
    userEmail = "CEwert@gmx.net";
  };

  # global tools
  programs.fzf.enable = true;
  programs.zoxide.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      custom = "$HOME/.oh-my-zsh/custom/";
      theme = "powerlevel10k/powerlevel10k";
      plugins = [ "git" "z" "fzf" ];
    };

    shellAliases = {
      ll = "ls -alh";
      gs = "git status";
    };

    history.size = 10000;

    initContent = ''
      # Powerlevel10k-Konfiguration laden (wenn vorhanden)
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

      # Freshfetch / Neofetch nur in interaktiven Shells anzeigen
      if [[ $- == *i* ]]; then
        if command -v freshfetch >/dev/null 2>&1; then
          freshfetch
        elif command -v neofetch >/dev/null 2>&1; then
          neofetch
        fi
      fi
    '';
  };

  # Benutzerpakete
  home.packages = with pkgs; [
    # --- Productivity ---
    libreoffice qownnotes thunderbird stirling-pdf

    # --- Media ---
    vlc gimp-with-plugins parabolic delfin

    # --- Communication ---
    ferdium teams-for-linux

    # --- CLI-Tools ---
    htop bat neofetch freshfetch

    # --- Development Tools ---
    vscode
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = false;
  };

  # --- dotfiles ---
  home.file = {
    ".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/mischka/dotfiles/nvim";
    };
  };

}
