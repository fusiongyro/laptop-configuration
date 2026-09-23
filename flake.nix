{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgsUnstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    kage.url = "github:fusiongyro/kage";
    kage.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:nix-community/stylix/release-26.05";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    hister.url = "github:asciimoo/hister";
    hister.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgsUnstable,
      home-manager,
      nixos-hardware,
      kage,
      stylix,
      hister,
    }@attrs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.iverson = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = attrs;
        modules = [
          ./configuration.nix
          nixos-hardware.nixosModules.framework-13-7040-amd
          stylix.nixosModules.stylix
        ];
      };

      homeConfigurations =
        let
          buildHome = (
            path: arch:
            let
              pkgs = nixpkgs.legacyPackages.${arch};
            in 
              home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [
                  ./home-generic.nix
                  path
                  stylix.homeModules.stylix
                  hister.homeModules.default
                ];
                extraSpecialArgs = {
                  inherit nixpkgsUnstable nixpkgs;
                  kage = kage.packages.${arch};
                };
              }
          );
        in
        {
          corkis = buildHome ./corkis.nix "aarch64-darwin";
          iverson = buildHome ./iverson.nix "x86_64-linux";
        };
    };
}
