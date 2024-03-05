{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }: {
    # replace 'joes-desktop' with your hostname here.
    nixosConfigurations.shevchenko = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./configuration.nix
        home-manager.nixosModules.home-manager
        ./home-manager.nix 
      ];
    };
  };
}
