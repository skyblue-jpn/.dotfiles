{ inputs, ... }:

{
  catppuccin = {
    enable = true;
    accent = "mauve";
    flavor = "macchiato";
    fcitx5.accent = "mauve";
    fcitx5.flavor = "catppuccin.flavor";
  };
}
