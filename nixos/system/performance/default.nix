{ pkgs, ... }:

{
  config = {
    # Automatically tune nice levels
    services.ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-rules-cachyos_git;
    };

    systemd.oomd.enable = false;

    # BPF-based auto-tuning of Linux system parameters
    services.bpftune.enable = true;

    ## A few other kernel tweaks
    boot.kernel.sysctl = {
      "kernel.nmi_watchdog" = 0;
      "kernel.sched_cfs_bandwidth_slice_us" = 3000;
      "net.core.rmem_max" = 2500000;
      "vm.max_map_count" = 16777216;
      # ZRAM is relatively cheap, prefer swap
      "vm.swappiness" = 180;
      # ZRAM is in memory, no need to readahead
      "vm.page-cluster" = 0;
    };

    # Use the Linux_cachyos kernel
    boot.kernelPackages = pkgs.linuxPackages_cachyos-rc;
  };
}
