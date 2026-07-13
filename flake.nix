{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgsUnstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    kage.url = "github:fusiongyro/kage";
    kage.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgsUnstable, home-manager, nixos-hardware, kage }@attrs:
  let system = "x86_64-linux"; in {
    # replace 'joes-desktop' with your hostname here.
    nixosConfigurations.iverson = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = attrs;
      modules = [ 
        ./configuration.nix
        nixos-hardware.nixosModules.framework-13-7040-amd
      ];
    };
    
    homeConfigurations."dlyons" = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./home.nix
      ];
      extraSpecialArgs = {
        inherit nixpkgsUnstable nixpkgs;
        kage = kage.packages.${system};
      };
    };
  };
}
