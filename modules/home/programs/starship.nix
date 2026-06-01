{ pkgs, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      format = "$username$hostname$directory$git_branch$git_status$cmd_duration$line_break$character";

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };

      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        format = "[$path]($style) ";
        style = "bold cyan";
      };

      git_branch = {
        format = "on [$symbol$branch]($style) ";
        symbol = " ";
        style = "bold purple";
      };

      git_status = {
        format = "([\\[$all_status$ahead_behind\\]]($style) )?";
        style = "bold red";
        conflicted = "=";
        ahead = "⇡";
        behind = "⇣";
        diverged = "⇕";
        untracked = "?";
        stashed = "$";
        modified = "!";
        staged = "+";
        renamed = "»";
        deleted = "✘";
      };

      cmd_duration = {
        min_time = 500;
        format = "took [$duration]($style) ";
        style = "bold yellow";
      };

      nix_shell = {
        disabled = false;
        symbol = "❄️  ";
        format = "via [$symbol]($style)";
        style = "bold blue";
      };

      rust = {
        symbol = "🦀 ";
        format = "via [$symbol]($style)";
        style = "bold red";
      };

      python = {
        symbol = "🐍 ";
        format = "via [$symbol]($style)";
        style = "bold yellow";
      };

      nodejs = {
        symbol = " ";
        format = "via [$symbol]($style)";
        style = "bold green";
      };
    };
  };
}
