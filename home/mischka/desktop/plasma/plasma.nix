{ ... }:

{
  programs.plasma = {
    enable = true;

    kwin = {
      virtualDesktops = {
        number = 2;
        rows = 1;
      };
    };

    workspace = {
      clickItemTo = "select";
    };
  };
}
