;;; init.el -*- lexical-binding: t; -*-
(doom!
 :completion
 (corfu +orderless)
 (vertico +icons)

 :ui
 doom
 doom-dashboard
 doom-quit
 hl-todo
 indent-guides
 modeline
 nav-flash
 ophints
 (popup +defaults)
 (vc-gutter +pretty)
 vi-tilde-fringe
 (window-select +numbers)
 workspaces

 :editor
 (evil +everywhere)
 file-templates
 fold
 (format +onsave +lsp)
 multiple-cursors
 snippets
 (whitespace +guess +trim)
 word-wrap

 :emacs
 (dired +dirvish +icons)
 electric
 tramp
 (undo +tree)
 vc

 :term
 vterm

 :checkers
 (syntax +childframe +icons)

 :tools
 debugger
 direnv
 editorconfig
 (eval +overlay)
 lookup
 (lsp +peek)
 (magit +forge)
 make
 (pass +auth)
 pdf
 tree-sitter
 upload

 :lang
 (cc +lsp +tree-sitter)
 (clojure +lsp +tree-sitter)
 data              
 emacs-lisp        
 (json +tree-sitter)              
 (latex +lsp +cdlatex)             
 (markdown +tree-sitter)
 org
 (python +lsp +pyright +tree-sitter)            
 (rest +jq)
 (rust +lsp)
 (sh +fish)           
 (web +lsp +tree-sitter)   
 (yaml +lsp +tree-sitter)     
 (javascript +lsp +tree-sitter)
 (julia +lsp +tree-sitter +snail)
 (nix +lsp +tree-sitter)

 :email
 notmuch

 :config
 (default +bindings +gnupg +smartparens))
