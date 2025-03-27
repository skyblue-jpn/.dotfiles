{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./R
  ];
  home.packages = with pkgs; [
    dotnet-sdk_9
    gcc
    inputs.fix-python.packages.${pkgs.system}.default
  ];
}
