{
  description = "Personal Nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    };

    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-26.05";
    };

    nix-plist-manager.url = "github:sushydev/nix-plist-manager";
  };

  outputs =
    {
      home-manager,
      nix-darwin,
      nix-plist-manager,
      nixpkgs,
      nixpkgs-unstable,
      self,
      ...
    }:

    {
      checks.aarch64-darwin.macbook-pro = self.darwinConfigurations.macbook-pro.system;
      checks.aarch64-linux.ubuntu-orb = self.homeConfigurations.ubuntu-orb.activationPackage;

      darwinConfigurations.macbook-pro = nix-darwin.lib.darwinSystem {
        modules = [
          nix-plist-manager.darwinModules.default

          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit nixpkgs-unstable; };
              sharedModules = [ nix-plist-manager.homeManagerModules.default ];
            };
          }

          ./hosts/macbook-pro/configuration.nix
        ];
      };

      homeConfigurations.ubuntu-orb = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-linux;
        extraSpecialArgs = { inherit nixpkgs-unstable; };
        modules = [ ./hosts/ubuntu-orb/configuration.nix ];
      };
    };
}
