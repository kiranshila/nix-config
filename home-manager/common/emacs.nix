{...}: {
  # Emacs
  # Doom will be configured externally
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [epkgs.vterm epkgs.pdf-tools];
  };
}
