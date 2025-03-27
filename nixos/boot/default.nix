{ config, ... }:

{
  imports = [
    ./grub
    ./plymouth
  ];

  boot = {
    consoleLogLevel = 0;
    # Make use of the systemd initrd
    initrd = {
      systemd.enable = true;
      systemd.strip = true;
      verbose = false;
    };
    # Make it quiet by default
    kernelParams = [
      "acpi_call"
      "quiet"
    ];
    tmp = {
      # Clean /tmp on boot if not using tmpfs
      cleanOnBoot = (!config.boot.tmp.useTmpfs);
    };
  };
}
