{
  description = "NixOS configuration for nixfred";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      nixfred = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";  # Adjust for your architecture
        modules = [ ./configuration.nix ];
      };
    };
  };
}
