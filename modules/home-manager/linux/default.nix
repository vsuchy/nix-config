{
  nixpkgs-unstable,
  pkgs,
  ...
}:

{
  home.packages = [
    nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.codex
  ];
}
