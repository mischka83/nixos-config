{ ... }:

{
  programs.plasma.workspace = {
    theme = "breeze-dark";
  };

  programs.plasma.kwin = {
    effects = {
      blur = true;
      translucency = true;
    };
  };
}
