{ ... }:

{
  imports = [
    ./flatpak.nix
    ./browsers/default.nix
    ./git.nix
    ./starship.nix
    ./vscode.nix
    ./powershell.nix
  ];
}
