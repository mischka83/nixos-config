{ config, pkgs, ... }:
{
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
      fu = "sudo nix flake update";
      nixbuild = "sudo nix flake update && sudo nixos-rebuild switch --flake /home/mischka/nixos-config#nixos-btw";
    };

    history.size = 10000;

    initContent = ''
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

      if [[ $- == *i* ]]; then
        if command -v freshfetch >/dev/null 2>&1; then
          fastfetch
        elif command -v neofetch >/dev/null 2>&1; then
          neofetch
        fi
      fi
    '';
  };

  programs.fzf.enable = true;
  programs.zoxide.enable = true;
}