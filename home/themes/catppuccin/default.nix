{ inputs, ... }:

{
  catppuccin = {
    enable = true;
    accent = "mauve";
    flavor = "macchiato";
    bat.flavor = "catppuccin.flavor";
    bottom.flavor = "catppuccin.flavor";
    cava.flavor = "catppuccin.flavor";
    cava.transparent = true;
    cursors.enable = "catppuccin.enable";
    cursors.accent = "catppuccin.accent";
    cursors.flavor = "catppuccin.flavor";
    delta.flavor = "catppuccin.flavor";
    dunst.flavor = "catppuccin.flavor";
    fcitx5.apply = true;
    fcitx5.accent = "catppuccin.accent";
    fcitx5.flavor = "catppuccin.flavor";
    fish.flavor = "catppuccin.flavor";
    fzf.accent = "catppuccin.accent";
    fzf.flavor = "catppuccin.flavor";
    ghostty.flavor = "catppuccin.flavor";
    gtk.enable = "catppuccin.enable";
    gtk.accent = "catppuccin.accent";
    gtk.flavor = "catppuccin.flavor";
    gtk.icon.accent = "catppuccin.accent";
    gtk.icon.flavor = "catppuccin.flavor";
    gtk.size = "compact";
    gtk.tweaks = "rimless";
    kvantum.apply = true;
    kvantum.accent = "catppuccin.accent";
    kvantum.flavor = "catppuccin.flavor";
    nvim.flavor = "catppuccin.flavor";
    starship.flavor = "catppuccin.flavor";
    yazi.accent = "catppuccin.accent";
    yazi.flavor = "catppuccin.flavor";
    zathura.flavor = "catppuccin.flavor";
    zsh-syntax-highlighting.flavor = "catppuccin.flavor";
  };
}
