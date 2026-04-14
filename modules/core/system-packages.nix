{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Development & Version Control
    git                # Distributed version control system
    zed-editor         # High-performance code editor
    diffutils          # GNU diff tools (diff, diff3, sdiff, cmp)
    delta              # Syntax-highlighting diff viewer (git-delta)

    # Office & Productivity
    onlyoffice-desktopeditors # Modern office suite (Writer, Calc, Impress)

    # System Administration & Boot
    sbctl              # Secure Boot Key Management
    efibootmgr         # EFI boot entry management

    # System Monitoring & Information
    htop               # Interactive system monitor
    fastfetch          # System information display (maintained actively)

    # Communication & Email
    thunderbird        # Email, calendar, and chat client
    remmina            # Remote desktop client (RDP/VNC/SSH)
    rustdesk           # Remote desktop / support client
    filezilla          # FTP/SFTP client
    vlc                # Media player
    zapzap

    # Archive & Compression Tools
    unzip              # Extract ZIP archives
    zip                # Create ZIP archives

    # Network & Download Tools
    curl               # Command-line download tool
    wget               # Download tool with retry support

    # Hardware & Graphics Debugging
    pciutils           # PCI bus information utility (lspci)
    mesa-demos         # OpenGL and graphics information (requires NVIDIA driver)

    # CLI Enhancements
    ripgrep            # Fast recursive grep (rg)
    fd                 # User-friendly find command replacement
    eza                # Modern ls replacement with colors
    tree               # Directory tree visualization
  ];
}
