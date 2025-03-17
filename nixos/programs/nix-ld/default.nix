{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.nix-ld.dev.enable = true;
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
