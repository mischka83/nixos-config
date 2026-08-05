{ ... }:

{
  imports = [
    ./flatpak.nix
    ./browsers/default.nix
    ./direnv.nix
    ./git.nix
    ./starship.nix
    ./vscode.nix
    ./powershell.nix
  ];
}
