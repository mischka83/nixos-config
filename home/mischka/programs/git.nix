{ ... }:

{
  programs.git = {
    enable = true;
    userName = "mischka";
    userEmail = "you@example.com";  # ACHTUNG: Bitte anpassen!

    settings = {
      init.defaultBranch = "main";
      pull.rebase = false;
      fetch.prune = true;
      diff.colorMoved = "zebra";
    };

    ignores = [
      "*~"
      "*.swp"
      ".DS_Store"
      "result"
      ".dirlocals"
    ];

    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      unstage = "restore --staged";
      last = "log -1 HEAD";
      visual = "log --graph --oneline --all";
    };
  };

  # SSH-Agent für Git
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };
}
