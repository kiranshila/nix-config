;;; init.el -*- lexical-binding: t; -*-
(doom! :input

       :completion
       (company +childframe) ; the ultimate code completion backend
       (vertico +icons)           ; the search engine of the future

       :ui
       doom              ; what makes DOOM look the way it does
       doom-dashboard    ; a nifty splash screen for Emacs
       doom-quit         ; DOOM quit-message prompts when you quit Emacs
       hl-todo           ; highlight TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW
       indent-guides     ; highlighted indent columns
       minimap           ; show a map of the code on the side
       modeline          ; snazzy, Atom-inspired modeline, plus API
       nav-flash         ; blink cursor line after big motions
       ophints           ; highlight the region an operation acts on
       (popup +defaults)   ; tame sudden yet inevitable temporary windows
       (vc-gutter +pretty) ; vcs diff in the fringe
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       (window-select +numbers)     ; visually switch windows
       workspaces        ; tab emulation, persistence & separate workspaces

       :editor
       (evil +everywhere); come to the dark side, we have cookies
       file-templates    ; auto-snippets for empty files
       fold              ; (nigh) universal code folding
       (format +onsave)  ; automated prettiness
       multiple-cursors  ; editing in many places at once
       snippets          ; my elves. They type so I don't have to
       word-wrap         ; soft wrapping with language-aware indent

       :emacs
       (dired +icons)             ; making dired pretty [functional]
       (undo +tree)              ; persistent, smarter undo for your inevitable mistakes
       vc                ; version-control and Emacs, sitting in a tree

       :term
       vterm             ; the best terminal emulation in Emacs

       :checkers
       (syntax +childframe)              ; tasing you for every semicolon you forget

       :tools
       (debugger +lsp)          ; FIXME stepping through code, to help you add bugs
       direnv
       (docker +lsp)
       editorconfig      ; let someone else argue about tabs vs spaces
       (eval +overlay)     ; run code, run (also, repls)
       lookup              ; navigate your code and its documentation
       (lsp +peek)       ; M-x vscode
       (magit +forge)             ; a git porcelain for Emacs
       make              ; run make tasks from Emacs
       (pass +auth)              ; password manager for nerds
       pdf               ; pdf enhancements
       tree-sitter       ; syntax and parsing, sitting in a tree...
       upload            ; map local to remote projects via ssh/ftp

       :lang
       (cc +lsp +tree-sitter)         ; C > C++ == 1
       (clojure +lsp)           ; java with a lisp
       data              ; config/data formats
       emacs-lisp        ; drown in parentheses
       (json +lsp +tree-sitter)              ; At least it ain't XML
       (latex +latexmk +lsp +cdlatex)             ; writing papers in Emacs has never been so fun
       markdown          ; writing docs for people to ignore
       (org +jupyter) ; organize your plain life in plain text
       (python +conda +lsp +pyenv +pyright +tree-sitter)            ; beautiful is better than ugly
       rest              ; Emacs as a REST client
       (rust +lsp +tree-sitter)       ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       (sh +fish +lsp)                ; she sells {ba,z,fi}sh shells on the C xor
       web               ; the tubes
       (yaml +lsp)              ; JSON, but readable
       (julia +lsp +tree-sitter +snail)
       (javascript +lsp +tree-sitter)
       (nix +tree-sitter +lsp)
       qt

       :config
       (default +bindings +smartparens))
