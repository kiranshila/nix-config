{
  pkgs,
  lib,
  ...
}: let
  # These follow from clojure-ts-grammar-recipes
  clojure-ts-grammar = pkgs.tree-sitter.buildGrammar {
    language = "clojure";
    version = "unstable-20250526";
    src = pkgs.fetchFromGitHub {
      owner = "sogaiu";
      repo = "tree-sitter-clojure";
      rev = "69070d2e4563f8f58c7f57b0c8e093a08d7a5814";
      sha256 = "sha256-+Miraf8kI8rZg7SYdfNM+mb78k9xNDUKYg3VTFzUHMo=";
    };
  };

  markdown-inline-grammar = pkgs.tree-sitter.buildGrammar rec {
    language = "markdown_inline";
    version = "0.4.1";
    src = pkgs.fetchFromGitHub {
      owner = "MDeiml";
      repo = "tree-sitter-markdown";
      tag = "v${version}";
      sha256 = "sha256-Oe2iL5b1Cyv+dK0nQYFNLCCOCe+93nojxt6ukH2lEmU=";
    };
    sourceRoot = "source/tree-sitter-markdown-inline";
  };

  regex-grammar = pkgs.tree-sitter.buildGrammar rec {
    language = "regex";
    version = "0.24.3";
    src = pkgs.fetchFromGitHub {
      owner = "tree-sitter";
      repo = "tree-sitter-regex";
      tag = "v${version}";
      sha256 = "sha256-GNWntm8sgqVt6a+yFVncjkoMOe7CnXX9Qmpwy6KcFyU";
    };
  };

  # Required by typst-ts-mode
  typst-grammar = pkgs.tree-sitter.buildGrammar rec {
    language = "typst";
    version = "nightly";
    src = pkgs.fetchFromGitHub {
      owner = "uben0";
      repo = language;
      rev = "master";
      sha256 = "sha256-s/9R3DKA6dix6BkU4mGXaVggE4bnzOyu20T1wuqHQxk=";
    };
  };
in {
  # Doom Emacs
  programs.doom-emacs = {
    enable = true;
    doomDir = ./doom;
    emacs = lib.mkDefault pkgs.emacs-pgtk; # Default to pure-gtk on wayland builds
    extraPackages = epkgs:
      with epkgs; [
        vterm
        pdf-tools
        (treesit-grammars.with-grammars
          (p:
            with p; [
              # Things from nixpkgs
              tree-sitter-bash
              tree-sitter-nix
              tree-sitter-fish
              tree-sitter-c
              tree-sitter-cpp
              tree-sitter-yaml
              tree-sitter-toml
              tree-sitter-json
              tree-sitter-python
              # Our custom ones
              regex-grammar
              markdown-inline-grammar
              clojure-ts-grammar
              typst-grammar
            ]))
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

    # LSPs
    taplo # TOML
    clojure-lsp # Clojure
    texlab # LaTeX
    ruff # Python linting
    pyright # Python
    yaml-language-server # YAML
    typescript-language-server # TS/JS
    openscad-lsp # OpenSCAD
    tinymist # Typst
  ];
}
