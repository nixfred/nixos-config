{
  description = "NixOS Configuration for nixosvm with Flakes";

  # Inputs
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  # Outputs
  outputs = { self, nixpkgs }: {
    nixosConfigurations.nixosvm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
    };
  };
}
