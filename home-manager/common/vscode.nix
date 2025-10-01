# Extensions and configuration for VSCode
{
  pkgs,
  config,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = config.lib.nixGL.wrap pkgs.vscodium;
    mutableExtensionsDir = false;
    profiles.default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      extensions = with pkgs.vscode-marketplace;
        [
          julialang.language-julia
          rust-lang.rust-analyzer
          tamasfe.even-better-toml
          citreae535.sparse-crates
          jnoortheen.nix-ide
          kamadorueda.alejandra
          catppuccin.catppuccin-vsc
          catppuccin.catppuccin-vsc-icons
          yzhang.markdown-all-in-one
          mkhl.direnv
          ms-python.python
          ms-toolsai.jupyter
          ms-toolsai.jupyter-renderers
          ms-vscode.cmake-tools
          llvm-vs-code-extensions.vscode-clangd
          charliermarsh.ruff
        ]
        ++ [
          pkgs.open-vsx.jeanp413.open-remote-ssh
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
        "git.confirmSync" = false;
        "git.autofetch" = true;
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
        "remote.SSH.useLocalServer" = true;
        "rust-analyzer.server.path" = "rust-analyzer"; # don't automatically download binary but use local one
      };
    };
  };
}
