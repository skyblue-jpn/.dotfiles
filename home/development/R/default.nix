{ pkgs, ... }:

{
  home.packages = with pkgs; [
    R
    radianWrapper
    (rWrapper.override {
      packages = with pkgs.rPackages; [
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
