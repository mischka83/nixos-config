{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -la";
      la = "ls -a";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline -10";
    };

    initContent = ''
      # Zsh history
      HISTSIZE=10000
      SAVEHIST=10000
      setopt HIST_SAVE_NO_DUPS
      setopt HIST_IGNORE_DUPS

      # Ctrl+Arrow Wortweise springen
      bindkey '^[[1;5C' forward-word   # Ctrl+Right
      bindkey '^[[1;5D' backward-word  # Ctrl+Left

      # Fastfetch beim Start
      command -v fastfetch >/dev/null && fastfetch
    '';
  };

  # Stelle sicher, dass fastfetch als Paket verfügbar ist
  home.packages = with pkgs; [
    fastfetch
  ];
}
