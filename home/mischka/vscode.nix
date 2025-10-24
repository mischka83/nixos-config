{ config, pkgs, ... }:

{
    programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
            dracula-theme.theme-dracula
            zhuangtongfa.material-theme
            catppuccin.catppuccin-vsc
            catppuccin.catppuccin-vsc-icons
            yzhang.markdown-all-in-one
            ms-vscode.powershell
            jnoortheen.nix-ide
            hashicorp.terraform
        ];
    };

}