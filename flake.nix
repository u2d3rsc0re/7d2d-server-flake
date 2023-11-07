{
    description = "NixOs module for the 7 Days to Die Dedicated server";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
        flake-utils.url = "github:numtide/flake-utils";
        steam-fetcher =  {
            url = "github:nix-community/steam-fetcher";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        self,
        nixpkgs,
        flake-utils,
        steam-fetcher,
    }:
    let
        pkgs = import nixpkgs {
            system = "x86_64-linux";
        };
    in {
        nixosModules = rec {
            _7d2d = import ./nixos-modules/7d2d.nix {inherit self steam-fetcher;};
            default = _7d2d;
        };
        overlays.default = final: prev: {
            _7d2d-server-unwrapped = final.callPackage ./pkgs/7d2d-server {};
            _7d2d-server = final.callPackage ./pkgs/7d2d-server/fhsenv.nix {};
        };
        packages."x86_64-linux" = {
            _7d2d-server-unwrapped = (pkgs.callPackage ./pkgs/7d2d-server {});
            _7d2d-server = (pkgs.callPackage ./pkgs/7d2d-server/fhsenv.nix {inherit steam-fetcher;});
        };
    };
}
