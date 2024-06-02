# Bare packages that don't need configuration
{pkgs, ...}: {
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
    tldr
    tmux

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

    # browser
    firefox

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
    (nerdfonts.override {fonts = ["FiraCode"];})

    # language toolchains
    # NOTE: Really, these should be installed as dev dependencies in a direnv
    julia-bin

    # notetaking
    obsidian

    # nix tools
    any-nix-shell
    nil

    # chat
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    slack

    # tools
    protonup-qt
    kicad
  ];
}