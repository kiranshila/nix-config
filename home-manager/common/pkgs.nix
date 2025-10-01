# Bare packages that don't need configuration
# All graphical programs need to be wrapped with NixGL to work on non-nixos
{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    # Very important
    neofetch
    cowsay
    lolcat

    # utils
    ripgrep
    grc
    fzf
    fd
    tealdeer
    tmux
    pciutils
    (config.lib.nixGL.wrap onlyoffice-bin)
    alejandra

    # Spelling and grammar
    (aspellWithDicts (dicts: with dicts; [en en-computers en-science]))

    # compression
    unzip

    # security
    qtpass

    # network
    iperf3

    # monitoring
    htop

    # Wine
    wineWowPackages.stable
    winetricks

    # Fonts
    julia-mono
    iosevka-bin
    (iosevka-bin.override {
      variant = "Aile";
    })
    (iosevka-bin.override {
      variant = "Slab";
    })
    (iosevka-bin.override {
      variant = "SGr-IosevkaTermSS09";
    })
    nerd-fonts.fira-code

    # nix tools
    any-nix-shell
    nil

    # chat
    (config.lib.nixGL.wrap slack)

    # tools
    protonup-qt
    (config.lib.nixGL.wrap kicad)
    (config.lib.nixGL.wrap freecad)
    (config.lib.nixGL.wrap zotero)
    dosfstools
    mtools
    cachix
    usbutils
    eza
    bat
    (config.lib.nixGL.wrap obsidian)
    julia-bin
    pdf2svg
    poppler
    (config.lib.nixGL.wrap zoom-us)

    # Build tools
    ninja
    cmake
    rustup

    # LSPs
    taplo

    # Remote control
    (config.lib.nixGL.wrap remmina)
  ];
}
