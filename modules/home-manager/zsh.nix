{
  config,
  ...
}:

{
  programs.zsh = {
    enable = true;

    initContent = "PROMPT='%F{blue}%~%f %F{green}❯%f '";
    history.path = "${config.xdg.stateHome}/zsh/.zsh_history";

    completionInit = ''
      mkdir -p "${config.xdg.cacheHome}/zsh"
      autoload -U compinit
      compinit -d "${config.xdg.cacheHome}/zsh/.zcompdump"
    '';

    autosuggestion = {
      enable = true;

      strategy = [
        "history"
        "completion"
      ];
    };

    syntaxHighlighting.enable = true;
  };
}
