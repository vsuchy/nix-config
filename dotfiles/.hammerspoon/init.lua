--
-- Hammerspoon configuration
--

-- Bind hotkey for reloading Hammerspoon configuration
hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift" }, "R", hs.reload)


PaperWM = hs.loadSpoon("PaperWM")

PaperWM.default_width = 0.5
PaperWM.window_gap = 10
PaperWM.window_ratios = { 0.5, 1.0 }
PaperWM:bindHotkeys(PaperWM.default_hotkeys)

PaperWM:start()
