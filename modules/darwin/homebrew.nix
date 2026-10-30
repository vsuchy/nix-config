let
  mkGreedy = caskName: { name = caskName; greedy = true; };
in

{
  homebrew = {
    enable = true;

    brews = [
      "mole"
    ];

    casks = map mkGreedy [
      "font-cascadia-code-nf"

      "chatgpt"
      "firefox"
      "ghostty"
      "hammerspoon"
      "orbstack"
      "tailscale-app"
      "whichspace"
      "zed"
    ];

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";

      extraEnv.HOMEBREW_NO_ANALYTICS = "1";
    };
  };
}
