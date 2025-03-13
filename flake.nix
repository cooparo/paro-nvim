{
  description = "Paro's neovim flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    neovim.url = "github:nix-community/neovim-nightly-overlay";
    neovim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      neovim,
    }:
    let
      system = "x86_64-linux";

      overlayFlakeInputs = prev: final: {
        neovim = neovim.packages.x86_64-linux.neovim;
      };

      overlayParoNeovim = prev: final: {
        paroNeovim = import ./packages/paroNeovim.nix {
          pkgs = final;
        };
      };

      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          overlayFlakeInputs
          overlayParoNeovim
        ];
      };
    in
    {
      packages.${system}.default = pkgs.paroNeovim;
      apps.${system}.default = {
        type = "app";
        program = "${pkgs.paroNeovim}/bin/nvim";
      };
    };
}
