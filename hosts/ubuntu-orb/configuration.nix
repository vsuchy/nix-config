{
  imports = [ ../../modules/home-manager ];

  home.username = "vs";
  home.homeDirectory = "/home/vs";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  targets.genericLinux = {
    enable = true;
    gpu.enable = false;
  };
}
