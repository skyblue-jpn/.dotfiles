{ inputs, ... }:

{
  catppuccin = {
    enable = true;
    accent = "mauve";
    flavor = "macchiato";
    grub.flavor = "catppuccin.flavor";
    plymouth.flavor = "catppuccin.flavor";
    sddm.assertQt6Sddm = true;
    sddm.flavor = "catppuccin.flavor";
    sddm.font = "Noto Sans CJK JP";
    sddm.fontSize = "9";
    sddm.loginBackground = true;
    tty.flavor = "catppuccin.flavor";
  };
}
