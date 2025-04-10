{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./formatter
    ./R
  ];
  home.packages = with pkgs; [
    dotnet-sdk_9
    clang
    clang-tools
    inputs.fix-python.packages.${pkgs.system}.default
  ];
}
