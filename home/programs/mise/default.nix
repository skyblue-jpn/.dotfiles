{ config, pkgs, inputs, ... }:

let
  # Import the rust overlay and select the Rust version
  rustOverlayPkgs = import inputs.nixpkgs {
    overlays = [ (import inputs.rust-overlay) ];
    system = pkgs.system;
  };

  # Use Rust 1.82.0
  rust182 = rustOverlayPkgs.rust-bin.stable."1.82.0".default;
in
{
  programs.mise = {
    enable = true;
    package = inputs.mise-flake.packages.${pkgs.system}.mise.overrideAttrs (old: {
      buildInputs = (old.buildInputs or []) ++ [ rust182 ];

      # Ensure cargo uses the correct Rust version
      CARGO_HOME = "${rust182}/.cargo";
      RUSTC = "${rust182}/bin/rustc";
      RUSTDOC = "${rust182}/bin/rustdoc";
    });
  };
}
