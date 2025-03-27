{ ... }:

{
  # Pipewire & wireplumber configuration
  services.pipewire = {
    alsa.enable = true;
    alsa.support32Bit = true;
    enable = true;
    pulse.enable = true;
    systemWide = false;
    wireplumber.enable = true;
  };

  # Enable the realtime kit
  security.rtkit.enable = true;

  # Disable PulseAudio
  services.pulseaudio.enable = false;
}
