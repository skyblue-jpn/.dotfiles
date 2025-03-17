{
  config,
  pkgs,
  lib,
  ...
}:

let
  devPackages = with pkgs; [
    bzip2
    cmake
    curl
    expat
    fuse3
    gcc
    gdbm
    git
    gnumake
    icu
    libffi
    libgcc
    ncurses
    nodejs
    nss
    openssl
    readline
    sqlite
    stdenv
    tclPackages.tk
    xz
    zlib
  ];
in
{
  programs.nix-ld.dev.enable = true;

  # Install additional global dev packages
  programs.nix-ld.dev.packages = devPackages;

  # Prepend the bin directories of the dev packages to the PATH so that their executables can be found
  programs.nix-ld.dev.extraPaths = lib.mkForce (map (pkg: "${pkg.outPath}/bin") devPackages);
}
