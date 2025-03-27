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
    clan
    inputs.fix-python.packages.${pkgs.system}.default
  ];
}
