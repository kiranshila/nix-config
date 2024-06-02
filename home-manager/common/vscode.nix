# Extensions and configuration for VSCode
{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-marketplace; [
      julialang.language-julia
      rust-lang.rust-analyzer
      tamasfe.even-better-toml
      serayuzgur.crates
      jnoortheen.nix-ide
      kamadorueda.alejandra
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      yzhang.markdown-all-in-one
      mkhl.direnv
      ms-python.python
    ];
    userSettings = {
      "editor.formatOnSave" = true;
      "window.zoomLevel" = 1;
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "editor.fontFamily" = "'Iosevka', 'Droid Sans Mono', 'monospace', monospace";
      "editor.fontSize" = 16;
      "editor.fontLigatures" = true;
      "workbench.startupEditor" = "none";
      "git.enableSmartCommit" = true;
      "workbench.colorTheme" = "Catppuccin Macchiato";
      "workbench.iconTheme" = "catppuccin-macchiato";
      "terminal.integrated.commandsToSkipShell" = [
        "language-julia.interrupt"
      ];
      "julia.additionalArgs" = [
        "-O3"
      ];
      "julia.NumThreads" = "auto";
      "julia.execution.resultType" = "inline, errors in REPL";
      "julia.symbolCacheDownload" = true;
      "julia.enableTelemetry" = false;
    };
  };
}
