{ pkgs }:
let
  customRC = import ../config { inherit pkgs; };
  plugins = import ../config { inherit pkgs; };
in
pkgs.wrapNeovim pkgs.neovim {
  configure = {
    inherit customRC;
  };
}
