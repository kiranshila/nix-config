;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Personal information
(setq! user-full-name "Kiran Shila" user-mail-address "me@kiranshila.com")

;; Fix Shell
(setq! shell-file-name (executable-find "bash"))
(setq-default vterm-shell (executable-find "fish"))

;; Fix SSH Agent
(setenv "SSH_AUTH_SOCK" (string-trim (shell-command-to-string "gpgconf --list-dirs agent-ssh-socket")))

;; Make sure the theme is loaded
(use-package! catppuccin-theme
  :config
  (load-theme 'catppuccin t t)
  (setq! catppuccin-flavor 'macchiato)
  (catppuccin-reload))

(setq! display-line-numbers-type t)
(setq! doom-theme 'catppuccin
       doom-font (font-spec :family "Iosevka Term SS09" :size 16)
       doom-symbol-font (font-spec :family "JuliaMono" :size 16)
       doom-variable-pitch-font (font-spec :family "Iosevka Aile" :size 16)
       doom-serif-font (font-spec :family "Iosevka Slab" :size 16))

;; Nyan Nyan
(after! doom-modeline (nyan-mode))

;; Plenty O' Ram
(setq! so-long-threshold 9000)

;; Buffer and window nav
(map!
 :leader
 (:prefix "b"
  :desc "Previous buffer" :n "p" #'previous-buffer
  :desc "Next buffer" :n "n" #'next-buffer
  :desc "Switch buffer" :n "b" #'switch-to-buffer)
 (:prefix "w"
  :desc "Vertical split" :n "/" #'evil-window-vsplit
  :desc "Horizontal split" :n "-" #'evil-window-split
  :desc "New frame" :n "F" #'make-frame
  :desc "Next frame" :n "o" #'other-frame
  :desc "Delete window" :n "d" #'evil-quit))

;; Remap SPC M to ,
(map! :n "," (cmd! (push (cons t ?m) unread-command-events)
                   (push (cons t 32) unread-command-events)))

;; Smartparens off hyper
(map!
 :ni "C-M-s-s" #'sp-forward-slurp-sexp
 :ni "C-M-s-S" #'sp-backward-slurp-sexp
 :ni "C-M-s-b" #'sp-forward-barf-sexp
 :ni "C-M-s-B" #'sp-backward-barf-sexp
 :ni "C-M-s-c" #'sp-convolute-sexp
 :ni "C-M-s-t" #'sp-transpose-sexp
 :ni "C-M-s-r" #'sp-raise-sexp
 :ni "C-M-s-w" #'sp-wrap-round
 :ni "C-M-s-u" #'sp-unwrap-sexp
 :ni "C-M-s-[" #'sp-wrap-square
 :ni "C-M-s-{" #'sp-wrap-curly
 :ni "C-M-s-j" #'sp-join-sexp
 :ni "C-M-s-|" #'sp-split-sexp)

(setq! projectile-project-search-path `("~/sync/Projects" "~/src"))

(setq! org-directory "~/sync/org/")

(use-package! smartparens
  :hook ((scheme-mode . smartparens-strict-mode)
         (clojure-mode . smartparens-strict-mode)
         (lisp-mode . smartparens-strict-mode)
         (emacs-lisp-mode . smartparens-strict-mode)))

(after! cider
  (setq cider-repl-pop-to-buffer-on-connect t))

;; Rust setup
(after! lsp-rust
  (setq! lsp-rust-analyzer-display-chaining-hints t)
  (setq! lsp-rust-analyzer-max-inlay-hint-length 25)
  (setq! lsp-rust-analyzer-proc-macro-enable t)
  (setq! lsp-inlay-hint-enable t)
  (setq! lsp-rust-analyzer-cargo-watch-command "clippy"))

;; Nix setup
(after! lsp-nix
  (setq! lsp-nix-nil-formatter ["alejandra" "--"]))

;; Enable horizontal scrolling
(setq! mouse-wheel-tilt-scroll t)
(setq! mouse-wheel-flip-direction t)

;; pdf-tools for latex preview
(setq! +latex-viewers '(pdf-tools))

;; OpenSCAD
(use-package! scad-mode
  :config
  ;; Enable the LSP
  (add-hook 'scad-mode-local-vars-hook #'lsp! 'append)
  ;; Preview mode switches to emacs mdoe
  (add-to-list 'evil-emacs-state-modes 'scad-preview-mode)
  (map!
   (:localleader
    (:map scad-mode-map
     :desc "Export"            "e" #'scad-export
     :desc "Open"              "o" #'scad-open
     :desc "Preview"           "p" #'scad-preview))
   (:map scad-preview-mode-map
    :desc "Distance+"          "[" #'scad-preview-distance+
    :desc "Distance-"          "]" #'scad-preview-distance-
    :desc "Toggle Projection"  "p" #'scad-preview-projection
    :desc "Translate x-"       "h" #'scad-preview-translate-x-
    :desc "Translate x+"       "l" #'scad-preview-translate-x+
    :desc "Translate y-"       "j" #'scad-preview-translate-y-
    :desc "Translate y+"       "k" #'scad-preview-translate-y+
    :desc "Translate z-"       "n" #'scad-preview-translate-z-
    :desc "Translate z+"       "m" #'scad-preview-translate-z+
    :desc "Rotate x-"          "H" #'scad-preview-rotate-x-
    :desc "Rotate x+"          "L" #'scad-preview-rotate-x+
    :desc "Rotate y-"          "J" #'scad-preview-rotate-y-
    :desc "Rotate y+"          "K" #'scad-preview-rotate-y+
    :desc "Rotate z-"          "N" #'scad-preview-rotate-z-
    :desc "Rotate z+"          "M" #'scad-preview-rotate-z+)))

;; Typst
(after! lsp-mode
  (add-to-list 'lsp-language-id-configuration '(typst-ts-mode . "typst"))

  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection '("tinymist"))
    :major-modes '(typst-ts-mode)
    :server-id 'tinymist
    :initialization-options (lambda ()
                              (lsp-ht ("formatterMode" "typstyle")
                                      ("exportPdf" "onSave"))))))

(use-package! typst-ts-mode
  :custom
  (typst-ts-watch-options "--open")
  (typst-ts-mode-enable-raw-blocks-highlight t)
  :config
  (add-hook 'typst-ts-mode-hook #'lsp! 'append)
  (set-popup-rule! "^\\*typst-ts-compilation\\*"
    :side 'bottom
    :size 0.5
    :select nil
    :ttl t)
  (map!
   (:localleader
    :map typst-ts-mode-map
    :desc "Compile document" "c" #'typst-ts-compile
    :desc "Preview document" "p" #'typst-ts-mode-preview)))
