self: super: {
  coreutils = super.coreutils.overrideAttrs (oldAttrs: rec {
    patches = (oldAttrs.patches or [ ]) ++ [ ./dont-remove-share.patch ];
  });
}
