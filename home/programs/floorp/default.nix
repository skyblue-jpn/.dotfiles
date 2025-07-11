{ ... }:

{
  programs.floorp = {
    enable = true;
    profiles.default.extensions.force = true;
  };
}
