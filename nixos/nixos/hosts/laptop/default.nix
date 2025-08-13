{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostName = "cloudjumper"; # Define your hostname.


  # environment.systemPackages = with pkgs; [
  #   swaynotificationcenter
  #
  #   streamcontroller
  #   ddcutil
  #
  #   hypridle
  #   waybar
  #   swww
  #   rofi-wayland
  #
  #   nwg-look
  #   rose-pine-hyprcursor
  #   hyprpolkitagent
  # ];
  #
  services.syncthing.settings.folders = {
    "notes" = {
      path = "/home/dragonblade316/Documents/notes/";
      devices = ["phone" "tablet" "desktop" "services" "docker-services"];
    };
    "Programming" = {
      path = "/home/dragonblade316/Programming/";
      devices = ["desktop"];
    };
  };
}
