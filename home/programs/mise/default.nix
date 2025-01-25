{ config, pkgs, inputs, rust-overlay, ... }:

let
  rustPkgs = import rust-overlay { inherit pkgs; };
  rustc = rustPkgs.rust-bin.stable."1.82.0".default;
in
{
  programs.mise = {
    enable = true;
    package = pkgs.callPackage inputs.mise {
      inherit rustc;
    };
  };
}
