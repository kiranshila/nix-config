# Bare packages that don't need configuration
# All graphical programs need to be wrapped with NixGL to work on non-nixos
{
  pkgs,
  config,
  ...
}: let
  cockatrice-beta = pkgs.cockatrice.overrideAttrs (oldAttrs: {
    version = "2.10.3";
    src = pkgs.fetchFromGitHub {
      owner = "Cockatrice";
      repo = "Cockatrice";
      rev = "2026-02-22-Release-2.10.3";
      hash = "sha256-GQVdn6vUW0B9vSk7ZvSDqMNhLNe86C+/gE1n6wfQIMw=";
    };
  });
in {
  home.packages = with pkgs; [
    # Very important
    neofetch
    cowsay
    lolcat

    # utils
    ripgrep
    grc
    fd
    tealdeer
    tmux
    pciutils
    (config.lib.nixGL.wrap onlyoffice-desktopeditors)
    (config.lib.nixGL.wrap looking-glass-client)
    alejandra
    veracrypt

    # Spelling and grammar
    (aspellWithDicts (
      dicts:
        with dicts; [
          en
          en-computers
          en-science
        ]
    ))

    # compression
    unzip

    # security
    qtpass

    # network
    iperf3

    # monitoring
    htop

    # Wine
    wineWow64Packages.stable
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
    (config.lib.nixGL.wrap musescore)
    (config.lib.nixGL.wrap muse-sounds-manager)

    # tools
    (config.lib.nixGL.wrap zotero)
    dosfstools
    mtools
    cachix
    usbutils
    (config.lib.nixGL.wrap obsidian)
    julia-bin
    pdf2svg
    poppler
    (config.lib.nixGL.wrap qucs-s)

    # Typst stuff
    typst
    typstyle

    # Build tools
    ninja
    cmake

    # Remote control
    (config.lib.nixGL.wrap remmina)

    # Photo Tools
    prusa-slicer

    # Games
    (config.lib.nixGL.wrap cockatrice-beta)
  ];
}
