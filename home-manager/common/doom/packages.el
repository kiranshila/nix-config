;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

(package! nyan-mode)
(package! catppuccin-theme)
(package! scad-mode)

(package! typst-ts-mode :recipe
  (:host codeberg
   :repo "meow_king/typst-ts-mode"))

;; Claude-code
(package! claude-code :recipe
  (:host github
   :repo "stevemolitor/claude-code.el"
   :branch "main"
   :depth 1
   :files ("*.el" (:exclude "images/*"))))

(package! inheritenv :recipe
  (:host github
   :repo "purcell/inheritenv"))

;; (package! monet :recipe
;;   (:host github
;;    :branch "main"
;;    :repo "purcell/inheritenv"))
