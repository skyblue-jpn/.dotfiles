{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "skyblue-jpn";
    userEmail = "82032866+skyblue-jpn@users.noreply.github.com";
  };

  # GitHub CLI
  programs.gh = {
    enable = true;
    extensions = with pkgs; [ gh-markdown-preview ];
    settings = {
      editor = "nvim";
    };
  };
}
