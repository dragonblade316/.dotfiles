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

  environment.systemPackages = with pkgs; [
    rose-pine-cursor
    gnome-tweaks
    zoom-us
  ];
  #
  services.syncthing.settings.folders = {
    "notes" = {
      path = "/home/dragonblade316/Documents/notes/";
      devices = ["phone" "tablet" "toothless"];
    };
    "Programming" = {
      path = "/home/dragonblade316/Programming/";
      devices = ["toothless"];
    };
  };

  systemd.services.fprintd = {
    wantedBy = ["multi-user.target"];
    serviceConfig.Type = "simple";
  };
  services.fprintd = {
    enable = true;
  };
}
