{
  config,
  nixpkgs-unstable,
  pkgs,
  ...
}:

{
  imports = [
    ./dotfiles.nix
    ./neovim.nix
    ./zsh.nix
  ];

  home.sessionVariables = {
    GEM_SPEC_CACHE = "${config.xdg.dataHome}/gem/specs";
  };

  home.shellAliases = {
    ls = "ls -Ahl --color=always --group-directories-first --time-style=+'%Y-%m-%d %H:%M:%S'";
    sudoe = "sudo -E";
  };

  home.packages = with pkgs; [
    ast-grep
    coreutils
    imagemagick
    jq
    ripgrep

    fastfetch
    git
    vifm
    vim

    # nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.codex
  ];
}
