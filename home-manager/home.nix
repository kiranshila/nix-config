# Home-Manager configuration
# Used to configure everything that isn't system-wide
{pkgs, ...}: {
  # Set my home directory
  home = {
    username = "kiran";
    homeDirectory = "/home/kiran";
  };

  # TODO Use nix-colors for ocatppuccin

  # Programs that don't require configuration
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
    aspell
    aspellDicts.en
    aspellDicts.en-science
    aspellDicts.en-computers

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

    # editors
    neovim
    neovide
    obsidian

    # nix tools
    alejandra
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

    # pretty
    lightly-qt

    # games
    osu-lazer
  ];

  # Iosevka

  # VSCode
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-marketplace; [
      julialang.language-julia
      rust-lang.rust-analyzer
      tamasfe.even-better-toml
      serayuzgur.crates
      jnoortheen.nix-ide
      kamadorueda.alejandra
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      yzhang.markdown-all-in-one
      mkhl.direnv
      ms-python.python
    ];
    userSettings = {
      "editor.formatOnSave" = true;
      "window.zoomLevel" = 1;
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "editor.fontFamily" = "'Iosevka', 'Droid Sans Mono', 'monospace', monospace";
      "editor.fontSize" = 16;
      "editor.fontLigatures" = true;
      "workbench.startupEditor" = "none";
      "workbench.colorTheme" = "Catppuccin Macchiato";
      "workbench.iconTheme" = "catppuccin-macchiato";
      "terminal.integrated.commandsToSkipShell" = [
        "language-julia.interrupt"
      ];
      "julia.additionalArgs" = [
        "-O3"
      ];
      "julia.NumThreads" = "auto";
      "julia.execution.resultType" = "inline, errors in REPL";
      "julia.symbolCacheDownload" = true;
      "julia.enableTelemetry" = false;
    };
  };

  # Enable fontconfig
  fonts.fontconfig.enable = true;

  # Setup alacritty for the terminal
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 7;
        bold = {
          style = "Bold";
        };
        bold_italic = {
          style = "Bold Italic";
        };
        italic = {
          style = "Oblique";
        };
        normal = {
          family = "Iosevka";
          style = "Regular";
        };
      };
      colors = {
        primary = {
          background = "#24273A";
          foreground = "#CAD3F5";
          dim_foreground = "#CAD3F5";
          bright_foreground = "#CAD3F5";
        };
        cursor = {
          text = "#24273A";
          cursor = "#F4DBD6";
        };
        vi_mode_cursor = {
          text = "#24273A";
          cursor = "#B7BDF8";
        };
        search = {
          matches = {
            foreground = "#24273A";
            background = "#A5ADCB";
          };
          focused_match = {
            foreground = "#24273A";
            background = "#A6DA95";
          };
        };
        footer_bar = {
          foreground = "#24273A";
          background = "#A5ADCB";
        };
        hints = {
          start = {
            foreground = "#24273A";
            background = "#EED49F";
          };
          end = {
            foreground = "#24273A";
            background = "#A5ADCB";
          };
        };
        selection = {
          text = "#24273A";
          background = "#F4DBD6";
        };
        normal = {
          black = "#494D64";
          red = "#ED8796";
          green = "#A6DA95";
          yellow = "#EED49F";
          blue = "#8AADF4";
          magenta = "#F5BDE6";
          cyan = "#8BD5CA";
          white = "#B8C0E0";
        };
        bright = {
          black = "#5B6078";
          red = "#ED8796";
          green = "#A6DA95";
          yellow = "#EED49F";
          blue = "#8AADF4";
          magenta = "#F5BDE6";
          cyan = "#8BD5CA";
          white = "#A5ADCB";
        };
        dim = {
          black = "#494D64";
          red = "#ED8796";
          green = "#A6DA95";
          yellow = "#EED49F";
          blue = "#8AADF4";
          magenta = "#F5BDE6";
          cyan = "#8BD5CA";
          white = "#B8C0E0";
        };
        indexed_colors = [
          {
            index = 16;
            color = "#F5A97F";
          }
          {
            index = 17;
            color = "#F4DBD6";
          }
        ];
      };
    };
  };

  # Email Accounts
  accounts.email.accounts = {
    "me@kiranshila.com" = {
      primary = true;
      thunderbird.enable = true;
      address = "me@kiranshila.com";
      userName = "me@kiranshila.com";
      realName = "Kiran Shila";
      imap = {
        host = "box.kiranshila.com";
        port = 993;
      };
      smtp = {
        host = "box.kiranshila.com";
        port = 465;
      };
    };
    "kshila@caltech.edu" = {
      thunderbird = {
        enable = true;
        settings = id: {
          # Use OAuth2 for IMAP and SMTP
          "mail.server.server_${id}.authMethod" = 10;
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
        };
      };
      address = "kshila@caltech.edu";
      userName = "kshila@caltech.edu";
      realName = "Kiran Shila";
      imap = {
        host = "outlook.office365.com";
        port = 993;
      };
      smtp = {
        host = "smtp.office365.com";
        port = 587;
        tls.useStartTls = true;
      };
    };
  };

  # Thunderbird configuration
  programs.thunderbird = {
    enable = true;
    profiles.default = {
      isDefault = true;
      withExternalGnupg = true;
    };
    settings = {
      "privacy.donottrackheader.enabled" = true;
      "mailnews.start_page.enabled" = false;
      "mail.default_send_format" = 1; # Plaintext only
      "mail.identity.default.reply_on_top" = 0; # Bottom-reply always
      "mail.identity.default.compose_html" = false; # Never compose HTML
    };
  };

  # Git config
  programs.git = {
    enable = true;
    userName = "Kiran Shila";
    userEmail = "me@kiranshila.com";
    lfs.enable = true;
    difftastic.enable = true;
    signing = {
      key = null;
      signByDefault = true;
    };
    extraConfig = {
      init = {defaultBranch = "main";};
      pull = {rebase = true;};
    };
  };

  # Enable and configure fish
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting
    '';
    plugins = [
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
    ];
  };

  # Use starship as the prompt
  programs.starship = {
    enable = true;
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Enable syncthing tray
  services.syncthing = {
    enable = true;
    tray.enable = true;
  };

  # Configure gpg
  programs.gpg = {
    enable = true;
    scdaemonSettings = {
      disable-ccid = true;
    };
    mutableKeys = false;
    mutableTrust = true;
    # Import my public key and give it ultimate trust
    publicKeys = [
      {
        source = ../publickey.gpg;
        trust = "ultimate";
      }
    ];
  };

  # Setup GPG Agent
  # Following Dr. Duh
  # https://raw.githubusercontent.com/drduh/config/master/gpg-agent.conf
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 60;
    maxCacheTtl = 120;
    pinentryPackage = pkgs.pinentry-qt;
  };

  # Setup pass
  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "/home/kiran/sync/.password-store";
    };
  };

  # SSH Config
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "grex" = {
        hostname = "grex.ovro.pvt";
        proxyJump = "ssh.ovro.caltech.edu";
        user = "user";
      };
    };
  };

  # Emacs
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
    extraPackages = epkgs: [epkgs.vterm];
  };

  programs.direnv.enable = true;

  # NixOS State Version for Home
  home.stateVersion = "23.11";
}
