{ pkgs, ... }:

{
  virtualisation.virtualbox = {
    # Enable VirtualBox host features
    host.enable = false;
    # Do not add host network interface
    host.addNetworkInterface = false;
    # Enable Extension Pack
    host.enableExtensionPack = true;
    # Enable KVM support
    host.enableKvm = true;
    # Disable VirtualBox guest features
    guest.enable = false;
    # Enable drag and drop with guest OS
    guest.dragAndDrop = true;
    # Enable clipboard sharing with guest OS
    guest.clipboard = true;
  };
}
