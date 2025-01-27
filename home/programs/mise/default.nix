{
  config,
  pkgs,
  inputs,
  ...
}:

#let
  # Import the rust overlay and select the Rust version
#  rustOverlayPkgs = import inputs.nixpkgs {
#    overlays = [ (import inputs.rust-overlay) ];
#    system = pkgs.system;
#  };

  # Use Rust latest
#  rustlatest = rustOverlayPkgs.rust-bin.stable.latest.default;
in
{
  programs.mise = {
    enable = true;
#    package = inputs.mise-flake.packages.${pkgs.system}.mise.overrideAttrs (old: {
#      buildInputs = (old.buildInputs or [ ]) ++ [ rustlatest ];

      # Ensure cargo uses the correct Rust version
#      CARGO_HOME = "${rustlatest}/.cargo";
#      RUSTC = "${rustlatest}/bin/rustc";
#      RUSTDOC = "${rustlatest}/bin/rustdoc";
#    });
  };

  home.file.".config/mise/config.toml" = {
    source = ./config.toml;
  };
}
