{
  description = "Vyryğ u konfiğuraciju";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    my-nixos-repo = {
      url = "github:KVarnitZ/MyNixOS/main";
      flake = false;
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.3-2.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hytale-launcher = {
      url = "github:TNAZEP/HytaleLauncherFlake";
      flake = true;
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, my-nixos-repo, lix-module, hytale-launcher, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
          "davinci-resolve"
        ];
      };
    in
    {
    nixosConfigurations."KVarnitZ" = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs unstable; };
      modules = [
        lix-module.nixosModules.default
        ./configuration.nix
        home-manager.nixosModules.home-manager
        ({ config, pkgs, ... }: {
          home-manager.users.kvarnitz = import "${my-nixos-repo}/etc/nixos/home.nix" { inherit config pkgs inputs; };
        })
        # Import fajliv z repozytoriju čerez flakes
        (import "${my-nixos-repo}/etc/nixos/zastosunky.nix")
        (import "${my-nixos-repo}/etc/nixos/konfiğy.nix")
        (import "${my-nixos-repo}/etc/nixos/temka/temka.nix")
      ];
    };
  };
}
