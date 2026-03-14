{ pkgs, ... }:

{
  # Zsh Shell mit Starship Integration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      # Navigation
      ll = "ls -la";
      la = "ls -a";

      # Git
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
    '';
  };
}
