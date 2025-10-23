{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgsUnstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixpkgsUnstable, home-manager, nixos-hardware }@attrs: {
    # replace 'joes-desktop' with your hostname here.
    nixosConfigurations.iverson = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
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

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules = [ ./home.nix ];

      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
      extraSpecialArgs = {
        inherit nixpkgsUnstable;
        inherit nixpkgs;
      };
    };
  };
}
