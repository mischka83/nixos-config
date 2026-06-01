{ pkgs, ... }:

{
  home.packages = with pkgs; [
    powershell
  ];

  home.file.".config/powershell/Microsoft.PowerShell_profile.ps1".text = ''
    # Keep shell output predictable in non-interactive tools.
    $ErrorActionPreference = 'Stop'

    # Common aliases for Linux workflows.
    Set-Alias ll Get-ChildItem
    Set-Alias grep Select-String

    function la {
      Get-ChildItem -Force
    }

    function lla {
      Get-ChildItem -Force -File
    }
  '';
}
