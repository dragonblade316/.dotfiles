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

  # waiting for cosmic beta to come to 25.05
  services.desktopManager.cosmic.enable = true;

  environment.systemPackages = with pkgs; [
    rose-pine-cursor
    gnome-tweaks
    zoom-us
  ];

  programs.dconf.profiles.user.databases = [
    {
      settings = {
        "org/gnome/mutter" = {
          experimental-features = [
            "scale-monitor-framebuffer" # Enables fractional scaling (125% 150% 175%)
            "variable-refresh-rate" # Enables Variable Refresh Rate (VRR) on compatible displays
            "xwayland-native-scaling" # Scales Xwayland applications to look crisp on HiDPI screens
          ];
        };
      };
    }
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
