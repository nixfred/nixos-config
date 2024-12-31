{
  description = "NixOS Configuration with Flakes";

  # Inputs
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  # Outputs
  outputs = { self, nixpkgs }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];
    };
  };
}
