{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          NIX_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath (
            with pkgs;
            [
              bzip2
              curl
              expat
              fuse3
              gdbm
              icu
              libffi
              libgcc
              ncurses
              nss
              openssl
              readline
              sqlite
              stdenv
              tclPackages.tk
              xz
              zlib
            ]
          );
        };
      }
    );
}
