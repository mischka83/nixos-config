{ ... }:

{
  # Optional AppImage support.
  # Keep this module unimported unless you want to use AppImages.
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
