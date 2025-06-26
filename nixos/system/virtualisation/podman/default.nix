{ config, pkgs, ... }:

{
  # Podmanを有効にする
  virtualisation.podman.enable = true;

  # (オプション) rootless Podman を有効にする場合
  # rootless Podman は、sudo なしでPodmanコマンドを実行できるようにします。
  security.wrappers.podman-rootless-user = {
    source = "${pkgs.podman}/bin/podman";
    permissions = "setuid";
  };
  users.users.celeste.extraGroups = [ "podman-rootless-user" ];

  # (オプション) ポートフォワーディングなどの高度なネットワーク機能が必要な場合
  # network.extraHosts = "host.containers.internal 10.0.2.2"; # 例: ホストへのアクセス

  # (オプション) SystemdサービスとしてPodmanソケットを有効にする場合
  # これは、PodmanのAPIを使用するツール (例: Docker Compose with Podman) に便利です。
  virtualisation.podman.enableSystemdSocket = true;
}
