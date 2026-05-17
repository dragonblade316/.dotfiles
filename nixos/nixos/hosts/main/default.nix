{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "toothless"; # Define your hostname.

  users.users.dragonblade316 = {
    extraGroups = ["adbusers" "dialout" "vboxusers"];
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # Xwayland can be disabled.
  };

  environment.systemPackages = with pkgs; [
    swaynotificationcenter

    streamcontroller
    ddcutil

    hypridle
    waybar
    awww
    rofi

    nwg-look
    rose-pine-hyprcursor
    hyprpolkitagent
    hyprpanel

    sidequest
    vivaldi

    godot
    arduino-ide
    scrcpy

    pkgsRocm.blender

    android-tools

    gimp
    krita

    julia-bin

    inputs.affinity-nix.packages.x86_64-linux.v3
  ];

  services.syncthing.settings.folders = {
    "notes" = {
      path = "/home/dragonblade316/Documents/notes/";
      # devices = ["phone" "tablet" "cloudjumper" "services" "docker-services"];
      devices = ["truenas"];
    };
    "Programming" = {
      path = "/home/dragonblade316/Programming/";
      devices = ["truenas"];
    };
  };

  services.restic.backups.toothless_backup.initialize = true;
  services.restic.backups.toothless_backup.user = "dragonblade316";
  services.restic.backups.toothless_backup.environmentFile = "/etc/nixos/restic-env";
  services.restic.backups.toothless_backup.paths = [
    "/home/dragonblade316/Documents"
    "/home/dragonblade316/Pictures"
    "/home/dragonblade316/Videos"
    "/home/dragonblade316/.dotfiles"
    "/home/dragonblade316/Music"
    "/home/dragonblade316/Programming"
    "/home/dragonblade316/Downloads"
  ];
  services.restic.backups.toothless_backup.exclude = [
    #I really dont need backups of builds
    "/home/dragonblade316/Programming/**/target"
    "/home/dragonblade316/Programming/**/build"
  ];
  services.restic.backups.toothless_backup.timerConfig = {
    OnCalendar = "02:00";
    Persistent = true;
  };

  #just a generic port for various tasks
  networking.firewall.allowedTCPPorts = [9000];
  networking.firewall.allowedUDPPorts = [9000];

  networking.firewall.extraCommands = ''
    iptables -A INPUT -p udp -d 224.0.0.0/4 -j ACCEPT
    iptables -A INPUT -p udp -s 224.0.0.0/4 -j ACCEPT
  '';

  #keeping this around so the udev rules are set. sdeck-ui is not currently used
  programs.streamdeck-ui = {
    enable = true;
    autoStart = false;
  };

  services.sunshine = {
    enable = false;
    autoStart = false;
    capSysAdmin = true;
    openFirewall = true;
  };

  virtualisation.virtualbox.host.enable = true;
  virtualisation.vmware.host.enable = true;
  #
  # services.ollama = {
  #   enable = true;
  #   # Optional: preload models, see https://ollama.com/library
  #   loadModels = ["qwen2.5-coder:1.5b"];
  #   package = pkgs.ollama-rocm;
  # };

  services.llama-cpp = {
    enable = true;
    package = pkgs.llama-cpp-rocm;
    openFirewall = true;
  };
}
