{
  config,
  pkgs,
  ...
}: {
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # networking.nameservers = ["192.168.12.12"];
  networking.networkmanager.insertNameservers = ["192.168.12.12"];

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
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

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
    blender-hip

    pulseaudio
    playerctl

    moonlight-qt

    #need to run a reley at some point
    tor-browser

    easyeffects
    obs-studio

    audacity
    ripgrep

    # pyright
    # rust-analyzer
    # lua-language-server
    # stylua

    busybox

    rustc
    cargo

    heroic

    wl-clipboard

    makemkv

    btop
    onlyoffice-desktopeditors
    nextcloud-client

    gparted
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withPython3 = true;
    withNodeJs = true;
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
          "desktop" = {id = "3JTYNYP-2XVDEVL-WY4V7SW-MDQQOGK-4AZW3SD-G3GH6DB-XFEZEDB-G6MQGA7";};
          "phone" = {id = "CGQHMOW-D57FW6E-J7OBE2U-ATYXMZP-ITTIBDF-MVUXTLD-NXBIWM4-KTUVCAA";};
          "tablet" = {id = "CY77CWR-7R26MUA-R6ISYHT-H4NZYZF-JN3DRIS-WXDIFBM-KZJ2FVS-EIU7LQF";};
          "laptop" = {id = "LSIB4GZ-XSX4CQF-IZB2PEE-7TXW74C-YXBBZ4Z-J2EXGZ3-FXPJVOV-2IYXYAP";};
          "services" = {id = "TLPNBI2-XL6BVKW-HD7NZZY-SP6OOVG-YER5USF-LSDBKSB-YSJQO7F-G2HIKQH";};
          "docker-services" = {id = "IAYTK6X-AUL6FYR-PMBIA5M-MS7U5UV-BSZPDK2-HE4M7OO-52RY33L-NPYBUQ3";};
        };
      };
    };
  };

  services.netbird = {
    enable = true;
    ui.enable = true;
  };

  xdg.mime.defaultApplications = {
    "text/html" = "";
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
  networking.firewall.allowedTCPPorts = [8384 22000];
  networking.firewall.allowedUDPPorts = [22000 21027];

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024;
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
