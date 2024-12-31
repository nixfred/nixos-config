{
  description = "NixOS Configuration for nixosvm with Flakes";

  # Inputs
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.home-manager.url = "github:nix-community/home-manager";

  # Outputs
  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations.nixosvm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
      ];
    };
  };
}

