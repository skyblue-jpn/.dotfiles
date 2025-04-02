{
  services.accounts-daemon.enable = true;
  services.gnome.gnome-online-accounts.enable = true;
  services.gvfs.enable = true;

  environment.variables = {
    # Set sandbox variable for gnome accounts to work
    WEBKIT_FORCE_SANDBOX = "0";
  };
}
