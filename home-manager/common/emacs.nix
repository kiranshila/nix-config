{
  config,
  pkgs,
  lib,
  ...
}: {
  # Doom Emacs
  programs.doom-emacs = {
    enable = true;
    doomDir = ./doom;
    emacs = lib.mkDefault pkgs.emacs-pgtk; # Default to pure-gtk on wayland builds
    extraPackages = epkgs: [
      epkgs.vterm
      epkgs.pdf-tools
      epkgs.treesit-grammars.with-all-grammars
    ];
    experimentalFetchTree = true;
  };

  # Emacs-required packages
  home.packages = with pkgs; [
    # Tools
    ripgrep
    fd
    jq

    # Fonts
    emacs-all-the-icons-fonts
    nerd-fonts.symbols-only

    # Email
    notmuch
    isync

    # LSPs
    taplo # TOML
    clojure-lsp # Clojure
    texlab # LaTeX
    ruff # Python linting
    pyright # Python
    yaml-language-server # YAML
    typescript-language-server # TS/JS
  ];
}
