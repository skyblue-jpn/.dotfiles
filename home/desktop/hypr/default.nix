{ config, pkgs, ... }:

{
  xdg.configFile = {
    "hypr/hyprland.conf".source = ./hyprland.conf;
    "hypr/hyprlock.conf".source = ./hyprlock.conf;
    "hypr/hypridle.conf".source = ./hypridle.conf;
    "hypr/settings/monitor.conf".source = ./settings/monitor.conf;
    "hypr/settings/background.conf".source = ./settings/background.conf;
    "hypr/settings/status_bar.conf".source = ./settings/status_bar.conf;
    "hypr/settings/window_gaps.conf".source = ./settings/window_gaps.conf;
    "hypr/settings/corners.conf".source = ./settings/corners.conf;
    "hypr/settings/blur_system.conf".source = ./settings/blur_system.conf;
    "hypr/settings/manual_settings.conf".source = ./settings/manual_settings.conf;
    "hypr/settings/animations.conf".source = ./settings/animations.conf;
    "hypr/themes/macchiato.conf".source = ./themes/macchiato.conf;
  };
  imports = [ ./utilities ];
}
