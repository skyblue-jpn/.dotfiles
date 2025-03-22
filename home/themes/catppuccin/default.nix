{ pkgs, inputs, ... }:

{
  catppuccin = {
    enable = true;
    accent = "mauve";
    flavor = "macchiato";
    bat.flavor = "macchiato";
    bottom.flavor = "macchiato";
    cava.flavor = "macchiato";
    cava.transparent = true;
    cursors.enable = true;
    cursors.accent = "mauve";
    cursors.flavor = "macchiato";
    delta.flavor = "macchiato";
    dunst.flavor = "macchiato";
    fcitx5.apply = true;
    fcitx5.accent = "mauve";
    fcitx5.flavor = "macchiato";
    fish.flavor = "macchiato";
    fzf.accent = "mauve";
    fzf.flavor = "macchiato";
    ghostty.enable = false;
    ghostty.flavor = "macchiato";
    gtk.enable = false;
    gtk.accent = "mauve";
    gtk.flavor = "macchiato";
    gtk.icon.accent = "mauve";
    gtk.icon.flavor = "macchiato";
    gtk.size = "compact";
    gtk.tweaks = [
      "rimless"
      "black"
    ];
    hyprland.accent = "mauve";
    hyprland.flavor = "macchiato";
    hyprlock.enable = false;
    hyprlock.accent = "mauve";
    hyprlock.flavor = "macchiato";
    kvantum.enable = false;
    kvantum.apply = false;
    kvantum.accent = "mauve";
    kvantum.flavor = "macchiato";
    nvim.flavor = "macchiato";
    # plymouth.flavor = "macchiato";
    # sddm.flavor = "macchiato";
    starship.enable = false;
    starship.flavor = "macchiato";
    tofi.flavor = "macchiato";
    vscode.enable = false;
    waybar.enable = false;
    waybar.flavor = "macchiato";
    waybar.mode = "prependImport";
    wlogout.accent = "mauve";
    wlogout.flavor = "macchiato";
    wlogout.iconStyle = "wleave";
    yazi.accent = "mauve";
    yazi.flavor = "macchiato";
    zathura.flavor = "macchiato";
    zsh-syntax-highlighting.flavor = "macchiato";
  };

  home.packages = with pkgs; [
    catppuccin-qt5ct
    catppuccin-kvantum
  ];
}
