{
  imports = [ ../../modules/darwin ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 7;

  networking.computerName = "vs-macbook-pro";
  networking.hostName = "vs-macbook-pro";
  networking.localHostName = "vs-macbook-pro";

  system.primaryUser = "vs";
  users.users.vs.home = "/Users/vs";

  # --- Home manager ---

  home-manager.users.vs = {
    imports = [
      ../../modules/home-manager
      ../../modules/home-manager/darwin
    ];

    home.stateVersion = "26.05";
  };
}
