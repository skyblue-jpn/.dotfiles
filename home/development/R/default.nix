{ pkgs, ... }:

let
  rPackagesToInstall = with pkgs.rPackages; [
    broom
    dplyr
    ggplot2
    httpgd
    janitor
    knitr
    languageserver
    lubridate
    plotly
    purrr
    readxl
    rmarkdown
    shiny
    stringr
    tidyr
    tidyverse
    writexl
  ];
in

{
  home.packages = with pkgs; [
    (rWrapper.override {
      packages = rPackagesToInstall;
    })
    (radianWrapper.override {
      packages = rPackagesToInstall;
    })
  ];

  home.sessionVariables = {
    R_PROFILE_USER = "$HOME/.Rprofile";
  };
  home.file = {
    ".Rprofile".source = ./.Rprofile;
    ".radian_profile".source = ./.radian_profile;
  };
}
