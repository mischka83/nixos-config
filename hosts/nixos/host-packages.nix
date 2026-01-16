{ pkgs, ... }: {
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # audacity
    # discord
    # nodejs
    # obs-studio
    # handbrake
  ];
}
