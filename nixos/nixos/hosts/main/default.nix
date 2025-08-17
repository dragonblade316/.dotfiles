{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "toothless"; # Define your hostname.

  programs.adb.enable = true;
  users.users.dragonblade316 = {
    extraGroups = ["adbusers"];
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
    swww
    rofi-wayland

    nwg-look
    rose-pine-hyprcursor
    hyprpolkitagent

    sidequest
    vivaldi
  ];

  services.syncthing.settings.folders = {
    "notes" = {
      path = "/home/dragonblade316/Documents/notes/";
      devices = ["phone" "tablet" "laptop" "services" "docker-services"];
    };
    "Programming" = {
      path = "/home/dragonblade316/Programming/";
      devices = ["laptop"];
    };
  };

  #keeping this around so the udev rules are set. sdeck-ui is not currently used
  programs.streamdeck-ui = {
    enable = true;
    autoStart = false;
  };

  services.sunshine = {
    enable = true;
    autoStart = false;
    capSysAdmin = true;
    openFirewall = true;
  };
}
