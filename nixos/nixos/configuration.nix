# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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

  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # Xwayland can be disabled.
  };

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
    extraGroups = ["networkmanager" "wheel"];
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
  environment.systemPackages = with pkgs; [
    neovim
    stow
    vesktop
    steam
    gh
    git
    gcc
    kitty
    distrobox
    waybar
    swww
    rofi
    yazi
    lazygit
    orca-slicer
    prismlauncher

    obsidian

    zsh
    zellij

    swaynotificationcenter
    starship
    zoxide
    lsd
    bat
    zsh-syntax-highlighting

    nwg-look
    rose-pine-hyprcursor

    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    docker-compose # start group of containers for dev

    alejandra
    blender-hip

    hypridle
  ];

  programs.streamdeck-ui = {
    enable = true;
    autoStart = true;
  };

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

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
          "phone" = {id = "CGQHMOW-D57FW6E-J7OBE2U-ATYXMZP-ITTIBDF-MVUXTLD-NXBIWM4-KTUVCAA";};
          "tablet" = {id = "CY77CWR-7R26MUA-R6ISYHT-H4NZYZF-JN3DRIS-WXDIFBM-KZJ2FVS-EIU7LQF";};
          "laptop" = {id = "LSIB4GZ-XSX4CQF-IZB2PEE-7TXW74C-YXBBZ4Z-J2EXGZ3-FXPJVOV-2IYXYAP";};
        };

        folders = {
          "notes" = {
            path = "/home/dragonblade316/Documents/notes/";
            devices = ["phone" "tablet" "laptop"];
          };
          "Programming" = {
            path = "/home/dragonblade316/Programming/";
            devices = ["laptop"];
          };
        };
      };
    };
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
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  #for syncthing
  networking.firewall.allowedTCPPorts = [8384 22000];
  networking.firewall.allowedUDPPorts = [22000 21027];

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
