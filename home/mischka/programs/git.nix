{ ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "mischka";
        email = "you@example.com";  # ACHTUNG: Bitte anpassen!
      };
      init.defaultBranch = "main";
      pull.rebase = false;
      fetch.prune = true;
      diff.colorMoved = "zebra";
      alias = {
        st = "status";
        co = "checkout";
        br = "branch";
        unstage = "restore --staged";
        last = "log -1 HEAD";
        visual = "log --graph --oneline --all";
      };
    };

    ignores = [
      "*~"
      "*.swp"
      ".DS_Store"
      "result"
      ".dirlocals"
    ];
  };

  # SSH-Agent für Git
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      addKeysToAgent = "yes";
    };
  };
}
