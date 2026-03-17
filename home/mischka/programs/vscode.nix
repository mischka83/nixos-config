{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        github.copilot
        github.copilot-chat
        eamodio.gitlens
        shd101wyy.markdown-preview-enhanced
        jgclark.vscode-todo-highlight
        esbenp.prettier-vscode
      ];

      userSettings = {
        "editor.formatOnSave" = true;
        "editor.minimap.enabled" = false;
        "files.insertFinalNewline" = true;
        "files.trimTrailingWhitespace" = true;
        "git.autofetch" = true;
        "git.confirmSync" = false;

        "gitlens.currentLine.enabled" = false;
        "gitlens.hovers.currentLine.over" = "line";

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

        "markdown-preview-enhanced.previewTheme" = "github-light.css";
        "markdown-preview-enhanced.codeBlockTheme" = "github.css";
        "markdown-preview-enhanced.scrollSync" = true;
      };
    };
  };
}