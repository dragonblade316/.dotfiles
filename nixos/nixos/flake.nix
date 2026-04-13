{
  description = "dragonblade316's nixos config";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    affinity-nix.url = "github:mrshmllow/affinity-nix";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    nixosConfigurations.toothless = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./common.nix
        ./hosts/main
        inputs.nvf.nixosModules.default
      ];
    };
    nixosConfigurations.cloudjumper = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./common.nix
        ./hosts/laptop
      ];
    };
  };
}
