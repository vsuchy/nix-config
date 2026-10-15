{
  pkgs,
  ...
}:

{
  imports = [ ./settings.nix ];

  home.sessionVariables = {
    HOMEBREW_NO_ANALYTICS = "1";
    HOMEBREW_NO_AUTO_UPDATE = "1";
    HOMEBREW_NO_INSTALL_CLEANUP = "1";
    SHELL_SESSIONS_DISABLE = "1";
  };

  home.file = {
    ".hammerspoon/init.lua".source = ../../../dotfiles/.hammerspoon/init.lua;
    ".hammerspoon/Spoons/PaperWM.spoon".source = pkgs.fetchFromGitHub {
      owner = "mogenson";
      repo = "PaperWM.spoon";
      rev = "e86139b4dfe9a181be900c7b21a54ee10a4a5a5d";
      hash = "sha256-U2hjZWBqQVUB+qjxjRGuJXSigi5nvlAcXd0pj7fms50=";
    };
  };
}
