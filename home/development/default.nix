{ pkgs, ... }:

{
  imports = [ ./nix-alien ];
  home.packages = with pkgs; [
    dotnet-sdk_9
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
  ];

  # If installed tools are not working, add the package here.
  home.sessionVariables.NIX_LD_LIBRARY_PATH = lib.makeLibraryPath (with pkgs; [ openssl ]);
}
