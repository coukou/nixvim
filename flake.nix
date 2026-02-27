{
  description = "Neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixvim
    , flake-parts
    , ...
    } @inputs: flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-linux"
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { system
        , self'
        , ...
        }:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          nixvim' = nixvim.legacyPackages."${system}";
          nvim = nixvim'.makeNixvimWithModule {
            inherit pkgs;
            module = [
              {
                imports = [
                  ./config
                ];
              }
            ];
            extraSpecialArgs = {
              inherit inputs system;
            };
          };
        in
        {
          packages.default = nvim;
        };
    };
}
