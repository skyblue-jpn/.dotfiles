{
  description = "Create a shell to build packages for mise-en-place";

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
        requiredPackages = with pkgs; [
          bzip2
          curl
          expat
          freetype
          fuse3
          gdbm
          gfortran
          gnumake
          icu
          libffi
          libgcc
          libjpeg
          libpng
          libtiff
          libxml2
          libxslt
          ncurses
          nss
          openblas
          openssl
          pcre2
          perl
          pkg-config
          python3
          readline
          sqlite
          stdenv
          tclPackages.tk
          xorg.libICE
          xorg.libX11
          xorg.libXt
          xz
          zlib
        ];
      in
      {
        devShells.default = pkgs.mkShell {
          packages = requiredPackages;
          NIX_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath requiredPackages;
        };
      }
    );
}
