{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;
    profiles.default = {
      extensions = with pkgs.vscode-marketplace; [
        github.copilot-chat
        eamodio.gitlens
        shd101wyy.markdown-preview-enhanced
        jgclark.vscode-todo-highlight
        esbenp.prettier-vscode
      ];

      userSettings = {
        # Layout & Appearance
        "workbench.activityBar.location" = "top";         # Activity Bar oben
        "workbench.sideBar.location" = "left";             # Sidebar links
        "workbench.editor.showTabs" = true;                # Editor Tabs zeigen
        "workbench.startupEditor" = "newUntitledFile";     # Neuer Tab beim Start

        # Editor
        "editor.formatOnSave" = true;
        "editor.minimap.enabled" = false;
        "editor.renderWhitespace" = "selection";           # Leerzeichen nur in Auswahl
        "editor.wordWrap" = "off";                         # Keine Wordwrap
        "editor.lineNumbers" = "on";                       # Zeilennummern
        "files.insertFinalNewline" = true;
        "files.trimTrailingWhitespace" = true;

        # Git & Source Control
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.ignoreLimitWarning" = true;

        # Gitlens
        "gitlens.currentLine.enabled" = false;
        "gitlens.hovers.currentLine.over" = "line";
        "gitlens.blame.highlight.locations" = [ "gutter" "line" "overview" ];

        # Terminal
        "terminal.integrated.defaultProfile.linux" = "zsh";
        "terminal.integrated.fontSize" = 12;
        "terminal.integrated.smoothScrolling" = true;

        # Prettier (Formatter)
        "prettier.semi" = true;
        "[javascript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[typescript]"."editor.defaultFormatter" = "esbenp.prettier-vscode";

        # Todo Highlight
        "todo-highlight.keywords" = [
          {
            text = "TODO:";
            color = "#111111";
            backgroundColor = "#FFD166";
          }
          {
            text = "FIXME:";
            color = "#FFFFFF";
            backgroundColor = "#D62828";
          }
          {
            text = "NOTE:";
            color = "#FFFFFF";
            backgroundColor = "#457B9D";
          }
          {
            text = "HACK:";
            color = "#FFFFFF";
            backgroundColor = "#8D5A97";
          }
        ];
        "todo-highlight.isCaseSensitive" = false;
        "todo-highlight.isEOLTagEnable" = false;

        "todohighlight.include" = [
          "**/*.js"
          "**/*.jsx"
          "**/*.ts"
          "**/*.tsx"
          "**/*.html"
          "**/*.css"
          "**/*.scss"
          "**/*.php"
          "**/*.rb"
          "**/*.txt"
          "**/*.mdown"
          "**/*.md"
          "**/*.nix"
        ];

        "markdown-preview-enhanced.previewTheme" = "github-light.css";
        "markdown-preview-enhanced.codeBlockTheme" = "github.css";
        "markdown-preview-enhanced.scrollSync" = true;

        # Sicherheit & Workspace
        "security.workspace.trust.untrustedFiles" = "open";
        "security.workspace.trust.enabled" = true;

        # Extensions
        "extensions.autoUpdate" = false;                   # Automatische Updates aus (über nix gesteuert)
      };
    };
  };
}
