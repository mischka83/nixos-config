{ config, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/home/base.nix
    ../../modules/home/dotfiles.nix
    ../../modules/home/firefox.nix
    ../../modules/home/git.nix
    ../../modules/home/packages.nix
    ../../modules/home/plasma.nix
    ../../modules/home/vscode.nix
    ../../modules/home/zsh/default.nix
  ];

}
