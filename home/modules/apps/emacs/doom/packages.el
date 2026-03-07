;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! nyan-mode)
(package! catppuccin-theme)
(package! scad-mode)

;; Must be pinned alongside eglot (see doomemacs/discussions#76)
(package! jsonrpc :pin "2bf7f24e39b6592faefef85e7553b2253c2ab87a")

(package! typst-ts-mode :recipe
  (:host codeberg
   :repo "meow_king/typst-ts-mode"))
