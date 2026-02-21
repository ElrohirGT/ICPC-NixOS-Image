{
  description = "ICP Image generation flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-25.11";
  };

  outputs = {nixpkgs, ...}: let
    # System types to support.
    supportedSystems = ["x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin"];

    # Helper function to generate an attrset '{ x86_64-linux = f "x86_64-linux"; ... }'.
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    # Nixpkgs instantiated for supported system types.
    nixpkgsFor = forAllSystems (system: import nixpkgs {inherit system;});
  in {
    devShells = forAllSystems (system: let
      pkgs = nixpkgsFor.${system};
    in {
      default = pkgs.mkShell {
        packages = [
          pkgs.go-task

          # Yaml formatting and linting
          pkgs.yamllint
          pkgs.yamlfmt

          pkgs.writedisk
        ];
      };
    });

    nixosConfigurations = let
      system = "x86_64-linux";
    in {
      simple = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/simple/configuration.nix
        ];
      };
      gnome = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/gnome/configuration.nix
        ];
      };
    };
  };
}
