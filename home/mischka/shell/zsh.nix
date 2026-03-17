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
      nrs = "nixos-switch";
      nrt = "nixos-test";
      nrb = "nixos-boot";
      nfu = "flake-update";
      nfc = "flake-check";
      ngc = "nix-cleanup";
      nso = "nix store optimise";
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

      # Host-aware Nix helpers for this flake setup
      export NIX_FLAKE_DIR="''${NIX_FLAKE_DIR:-$HOME/nixos-config}"
      export NIX_HOST="''${NIX_HOST:-$(hostname)}"

      nixos-switch() {
        sudo nixos-rebuild switch --flake "$NIX_FLAKE_DIR#$NIX_HOST" "$@"
      }

      nixos-test() {
        sudo nixos-rebuild test --flake "$NIX_FLAKE_DIR#$NIX_HOST" "$@"
      }

      nixos-boot() {
        sudo nixos-rebuild boot --flake "$NIX_FLAKE_DIR#$NIX_HOST" "$@"
      }

      flake-update() {
        nix flake update "$NIX_FLAKE_DIR" "$@"
      }

      flake-check() {
        nix flake check "$NIX_FLAKE_DIR" "$@"
      }

      nix-cleanup() {
        nix-collect-garbage -d
        sudo nix-collect-garbage -d
      }

      # Fastfetch beim Start
      command -v fastfetch >/dev/null && fastfetch
    '';
  };

  # Stelle sicher, dass fastfetch als Paket verfügbar ist
  home.packages = with pkgs; [
    fastfetch
  ];
}
