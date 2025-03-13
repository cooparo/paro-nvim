{ pkgs }:
let
  customRC = import ../config { inherit pkgs; };
  plugins = import ../plugins.nix { inherit pkgs; };
in
pkgs.wrapNeovim pkgs.neovim {
  configure = {
    inherit customRC;

    # Load all plugin in plugins.nix at start
    packages.all.start = plugins;
  };
}
