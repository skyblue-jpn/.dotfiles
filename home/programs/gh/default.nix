{ ... }:

{
  programs.gh = {
    enable = false;
    settings = {
      git_protocol = "ssh";
      editor = "nvim";
    };
  };
}
