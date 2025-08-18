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
        home-manager.nixosModules.home-manager
        ./home-manager.nix 
        nixos-hardware.nixosModules.framework-13-7040-amd
      ];
    };
  };
}
