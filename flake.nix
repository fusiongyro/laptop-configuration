{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/24.05";
    nixpkgsUnstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgsUnstable, home-manager }@attrs: {
    # replace 'joes-desktop' with your hostname here.
    nixosConfigurations.shevchenko = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ 
        ./configuration.nix
        home-manager.nixosModules.home-manager
        ./home-manager.nix 
      ];
    };
  };
}
