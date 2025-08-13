{
  description = "dragonblade316's nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.05";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    nixosConfigurations.toothless = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./common.nix
        ./hosts/main
      ];
    };
    nixosConfigurations.cloudjumper = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./common
        ./hosts/laptop
      ];
    };
  };
}
