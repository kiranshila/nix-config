;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Personal information
(setq! user-full-name "Kiran Shila" user-mail-address "me@kiranshila.com")

;; Fix Shell
(setq! shell-file-name (executable-find "bash"))
(setq-default vterm-shell (executable-find "fish"))

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

(with-eval-after-load 'cider
  (setq cider-repl-pop-to-buffer-on-connect t))

;; Rust setup
(with-eval-after-load `lsp-rust
  (setq! lsp-rust-analyzer-display-chaining-hints t)
  (setq! lsp-rust-analyzer-max-inlay-hint-length 25)
  (setq! lsp-rust-analyzer-proc-macro-enable t)
  (setq! lsp-inlay-hint-enable t)
  (setq! lsp-rust-analyzer-cargo-watch-command "clippy"))

;; Enable horizontal scrolling
(setq! mouse-wheel-tilt-scroll t)
(setq! mouse-wheel-flip-direction t)

;; pdf-tools for latex preview
(setq! +latex-viewers '(pdf-tools))

;; TOML language server
(after! lsp-mode
  (add-to-list 'lsp-language-id-configuration '(toml-mode . "toml"))
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection "taplo")
                    :activation-fn (lsp-activate-on "toml")
                    :server-id 'taplo)))

;; Email
(setq +notmuch-sync-backend 'mbsync)
