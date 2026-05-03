{
  config,
  pkgs,
  ...
}: {
  # copy.fail mitigation, until we're on a kernel that has it patched
  boot.extraModprobeConfig = "install algif_aead /bin/false";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.trusted-users = ["root" "dragonblade316"];

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.nameservers = ["1.1.1.1"];
  # networking.networkmanager.insertNameservers = ["192.168.12.12"];
  # networking.networkmanager.insertNameservers = ["1.1.1.1"];

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Boise";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.udev.extraRules = ''SUBSYSTEM=="usb", ATTRS{idVendor}=="03e7", MODE="0666"'';

  hardware.i2c.enable = true;

  boot.kernelModules = ["sg"];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs.zsh = {
    enable = true;
    syntaxHighlighting = {
      enable = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dragonblade316 = {
    isNormalUser = true;
    description = "Teddy";
    extraGroups = ["networkmanager" "wheel" "i2c"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  #upackages
  environment.systemPackages = with pkgs; [
    stow
    vesktop
    gh
    git
    gcc
    kitty
    distrobox
    yazi
    lazygit
    orca-slicer
    prismlauncher
    hyprshot

    obsidian
    zoom-us

    zsh
    zellij

    starship
    zoxide
    lsd
    bat
    zsh-syntax-highlighting

    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    docker-compose # start group of containers for dev

    alejandra
    # blender-hip

    pulseaudio
    playerctl

    moonlight-qt

    #need to run a reley at some point
    tor-browser

    easyeffects
    obs-studio

    audacity
    ripgrep
    fzf

    # pyright
    # rust-analyzer
    # lua-language-server
    # stylua

    busybox

    helix

    rustc
    pixi
    cargo
    jetbrains.idea-oss
    python313
    pipx
    go
    devenv

    heroic

    wl-clipboard

    kickstart

    # makemkv

    btop
    onlyoffice-desktopeditors
    nextcloud-client

    gparted

    pavucontrol

    google-chrome
    imagemagick
    hyprpanel

    pangolin-cli

    gst_all_1.gstreamer
    ffmpeg
  ];
  #
  # programs.neovim = {
  #   enable = true;
  #   defaultEditor = true;
  #   withPython3 = true;
  #   withNodeJs = true;
  # };

  # #nvf config
  # vim = {
  #   theme = {
  #     enable = true;
  #     name = "dracula";
  #     style = "dark";
  #   };
  # };
  #
  programs.nvf = {
    enable = true;
    # Your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim = {
        theme = {
          enable = true;
          name = "dracula";
          style = "dark";
        };
        lineNumberMode = "number";

        keymaps = [
          {
            key = "jk";
            mode = ["i"];
            action = "<Esc>";
            silent = true;
            desc = "New esc keybind";
          }
          {
            key = "<leader>t";
            mode = ["n"];
            action = ":Trouble diagnostics toggle<CR>";
            silent = true;
            desc = "open error list";
          }
          {
            key = "\\";
            mode = ["n"];
            action = ":Neotree toggle<CR>";
            silent = true;
            desc = "open neotree";
          }
          {
            key = "<leader>gg";
            mode = ["n"];
            action = ":Neogit<CR>";
            silent = true;
            desc = "open neogit";
          }

          #telescope bindings
          {
            key = "<leader>f";
            mode = ["n"];
            action = ":Telescope fd<CR>";
            silent = true;
            desc = "find files with telescope";
          }
          {
            key = "<leader>/";
            mode = ["n"];
            action = ":Telescope live_grep<CR>";
            silent = true;
            desc = "find something with telescope";
          }
        ];

        autocomplete.blink-cmp.enable = true;

        filetree.neo-tree.enable = true;

        clipboard = {
          enable = true;
          providers.wl-copy.enable = true;
        };

        utility.motion.flash-nvim.enable = true;
        autopairs.nvim-autopairs.enable = true;

        #gitsigns
        git.git-conflict.enable = true;
        git.neogit.enable = true;

        telescope = {
          enable = true;
          # extensions = [
          #   {
          #     name = "fzf";
          #     packages = [pkgs.vimPlugins.telescope-fzf-native-nvim];
          #     setup = {fzf = {fuzzy = true;};};
          #   }
          # ];
        };

        languages = {
          enableTreesitter = true;
          enableLSP = true;
          enableFormat = true;
          enableDAP = true;

          nix.enable = true;
          rust.enable = true;
          markdown.enable = true;
          clang.enable = true;
          java.enable = true;
          python.enable = true;
          dart.enable = true;
          dart.flutter-tools.enable = true;
        };

        treesitter = {
          enable = true;
          indent.enable = true;
        };

        options = {
          #Indent
          tabstop = 2; # 2 spaces for tabs (prettier default)
          shiftwidth = 2; # 2 spaces for indent width
          expandtab = true; # expand tab to spaces
          autoindent = true; # copy indent from current line when starting new one
          copyindent = true;
          smartindent = true;
          preserveindent = true;
        };
      };

      vim.viAlias = false;
      vim.vimAlias = true;
      vim.lsp = {
        enable = true;
        trouble.enable = true;
        mappings.codeAction = "<leader>ca";
      };
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
  };

  environment.variables = {
    RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
  };

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  programs.alvr = {
    enable = true;
    openFirewall = true;
  };

  services.keyd.enable = true;
  services.keyd.keyboards = {
    default = {
      ids = ["*"];
      settings = {
        main = {
          capslock = "backspace";
        };
      };
    };
  };

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  services.flatpak.enable = true;

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.arimo
    nerd-fonts.atkynson-mono
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/dragonblade316/nixos";
  };

  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  services = {
    syncthing = {
      enable = true;
      # group = "mygroupname";
      user = "dragonblade316";
      dataDir = "/home/dragonblade316/Documents/"; # Default folder for new synced folders
      # configDir = "/home/myusername/Documents/.config/syncthing";   # Folder for Syncthing's settings and keys
      settings = {
        devices = {
          # "laptop" = { id = "" };
          # "toothless" = {id = "3JTYNYP-2XVDEVL-WY4V7SW-MDQQOGK-4AZW3SD-G3GH6DB-XFEZEDB-G6MQGA7";};
          # "phone" = {id = "6PXQE3E-BGZN4CK-CGFP6HC-A2KS2HF-OK5TWLL-B4VAEMG-F7LB2PS-2EZGMQL";};
          # "tablet" = {id = "CY77CWR-7R26MUA-R6ISYHT-H4NZYZF-JN3DRIS-WXDIFBM-KZJ2FVS-EIU7LQF";};
          # "cloudjumper" = {id = "3AOAZJX-ESSUUFU-I2IBEXZ-PFZJEOY-FUGKVHO-52SWEIH-HF3RZ2E-FEFNFQA";};
          # "services" = {id = "TLPNBI2-XL6BVKW-HD7NZZY-SP6OOVG-YER5USF-LSDBKSB-YSJQO7F-G2HIKQH";};
          # "docker-services" = {id = "IAYTK6X-AUL6FYR-PMBIA5M-MS7U5UV-BSZPDK2-HE4M7OO-52RY33L-NPYBUQ3";};
          "truenas" = {id = "5IWV7P7-LFLOLMV-QNLEYAG-SMTHEQO-VE6PF4U-O3XY7SG-GM2VYY3-Y4WJXQX";};
        };
      };
    };
  };

  services.netbird = {
    enable = false;
    ui.enable = true;
  };

  xdg.mime.enable = true;
  xdg.mime.defaultApplications = {
    "text/html" = "app.zen_browser.zen.desktop";
    "x-scheme-handler/http" = "app.zen_browser.zen.desktop";
    "x-scheme-handler/https" = "app.zen_browser.zen.desktop";
    "x-scheme-handler/about" = "app.zen_browser.zen.desktop";
    "x-scheme-handler/unknown" = "app.zen_browser.zen.desktop";
    "x-scheme-handler/stl" = "orca.desktop";
  };

  system.autoUpgrade = {
    enable = true;
    dates = "04:00";
    flake = "${config.users.users.dragonblade316.home}/nixpkgs";
    flags = [
      "--update-input"
      "nixpkgs"
    ];
    allowReboot = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  #for syncthing
  networking.firewall.allowedTCPPorts = [8384 22000 25565];
  networking.firewall.allowedUDPPorts = [22000 21027];

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024;
    }
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [
    pkgs.stdenv.cc.cc
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
