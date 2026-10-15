{
  pkgs,
  ...
}:

{
  imports = [
    ./homebrew.nix
    ./settings.nix
  ];

  nix = {
    channel.enable = false;

    settings.experimental-features = [
      "flakes"
      "nix-command"
    ];
  };

  programs.zsh = {
    enable = true;
    enableGlobalCompInit = false;
  };
}
