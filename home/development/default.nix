{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./formatter
    ./podman
    ./R
  ];
  home.packages = with pkgs; [
    dotnet-sdk_9
    clang
    clang-tools
    nodejs
    inputs.fix-python.packages.${pkgs.system}.default
  ];
}
