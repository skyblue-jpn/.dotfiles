{
  environment.sessionVariables = {
    BROWSER = "floorp";
    TERMINAL = "ghostty";
    EDITOR = "nvim";
    XMODIFIERS = "@im=fcitx";
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    INPUT_METHOD = "fcitx";
    NIX_USER_CONF_FILES = "~/.config/nix/nix.conf:~/.config/nix/local.conf"; # define nix conf: DO NOT MANAGE BY PUBLIC REPO
  };
}
