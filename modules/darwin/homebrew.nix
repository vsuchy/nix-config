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
      "tailscale-app"
      "virtualbuddy@beta"
    ];

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";

      extraEnv.HOMEBREW_NO_ANALYTICS = "1";
    };
  };
}
