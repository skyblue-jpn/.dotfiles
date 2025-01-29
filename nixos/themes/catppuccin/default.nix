{ inputs, ... }:

{
  catppuccin = {
    enable = true;
    accent = "mauve";
    flavor = "macchiato";
    grub.flavor = "macchiato";
    plymouth.flavor = "macchiato";
    sddm.assertQt6Sddm = true;
    sddm.flavor = "macchiato";
    sddm.font = "Noto Sans CJK JP";
    sddm.fontSize = "9";
    sddm.loginBackground = true;
    tty.flavor = "macchiato";
  };
}
