{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Development & Version Control
    git                # Distributed version control system
    zed-editor         # High-performance code editor

    # Office & Productivity
    onlyoffice-bin     # Modern office suite (Writer, Calc, Impress)

    # System Administration & Boot
    sbctl              # Secure Boot Key Management
    efibootmgr         # EFI boot entry management

    # System Monitoring & Information
    htop               # Interactive system monitor
    neofetch           # System information display

    # Communication & Email
    thunderbird        # Email, calendar, and chat client

    # Archive & Compression Tools
    unzip              # Extract ZIP archives
    zip                # Create ZIP archives

    # Network & Download Tools
    curl               # Command-line download tool
    wget               # Download tool with retry support

    # CLI Enhancements
    ripgrep            # Fast recursive grep (rg)
    fd                 # User-friendly find command replacement
    eza                # Modern ls replacement with colors
    tree               # Directory tree visualization
  ];
}
