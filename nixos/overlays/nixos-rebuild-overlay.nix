self: super: {
  nixos-rebuild = super.nixos-rebuild.overrideAttrs (oldAttrs: {
    buildInputs = (oldAttrs.buildInputs or [ ]) ++ [ super.coreutils ];
  });
}
