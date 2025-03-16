{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Enable nix ld
  programs.nix-ld.enable = true;

  # Sets up all the libraries to load
  programs.nix-ld.libraries = lib.mkForce (
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
}
