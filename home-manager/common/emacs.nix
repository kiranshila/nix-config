{
  config,
  pkgs,
  ...
}: {
  # Doom Emacs
  programs.doom-emacs = {
    enable = true;
    doomDir = ./doom;
    emacs = config.lib.nixGL.wrap pkgs.emacs;
    extraPackages = epkgs: [
      epkgs.vterm
      epkgs.pdf-tools
      epkgs.treesit-grammars.with-all-grammars
    ];
    experimentalFetchTree = true;
  };
}
