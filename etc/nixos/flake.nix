{
  description = "Жорстко надристав у систему, оооуууу єєєєс!";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    my-nixos-repo = {
      url = "github:KVarnitZ/MyNixOS/main";
      flake = false;
    };
    playit-nixos-module = {
      url = "github:pedorich-n/playit-nixos-module";
    };
  };

  outputs = { self, nixpkgs, home-manager, my-nixos-repo, playit-nixos-module, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
    nixosConfigurations."KVarnitZ" = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        playit-nixos-module.nixosModules.default
        ./configuration.nix
        home-manager.nixosModules.home-manager
        ({ config, pkgs, ... }: {
          home-manager.users.kvarnitz = import "${my-nixos-repo}/etc/nixos/home.nix" { inherit config pkgs inputs; };
        })
        # Імпорт файлів з репозиторію через flakes
        (import "${my-nixos-repo}/etc/nixos/zastosunky.nix")
        (import "${my-nixos-repo}/etc/nixos/konfihy.nix")
        (import "${my-nixos-repo}/etc/nixos/temka/temka.nix")
      ];
    };
  };
}
