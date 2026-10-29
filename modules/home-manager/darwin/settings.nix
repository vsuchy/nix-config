{
  programs.nix-plist-manager = {
    enable = true;

    options.applications.systemSettings = {
      # --- General ---

      # System Settings › General › AirDrop & Continuity › Allow Handoff between this Mac and your iCloud devices
      general.airDropAndContinuity.allowHandoffBetweenThisMacAndYourIcloudDevices = false;

      # System Settings › General › AirDrop & Continuity › iPhone Widgets
      general.airDropAndContinuity.iPhoneWidgets = false;

      # System Settings › General › AirDrop & Continuity › AirPlay Receiver
      general.airDropAndContinuity.airPlayReceiver = false;

      # System Settings › General › Language & Region › Date format
      general.languageAndRegion.dateFormat = "19.08.2026";

      # --- Appearance ---

      # System Settings › Appearance › Appearance
      appearance.appearance = "Dark";

      # System Settings › Appearance › Windows › Tint window background with wallpaper color
      appearance.allowWallpaperTintingInWindows = false;

      # System Settings › Appearance › Windows › Show scroll bars
      appearance.showScrollBars = "Always";

      # System Settings › Appearance › Windows › Click in the scroll bar to
      appearance.clickInTheScrollBarTo = "Jump to the spot that's clicked";

      # --- Desktop & Dock ---

      # System Settings › Desktop & Dock › Dock › Window title bar double-click action
      desktopAndDock.dock.windowTitleBarDoubleClickAction = "No Action";

      # System Settings › Desktop & Dock › Dock › Automatically hide and show the Dock
      desktopAndDock.dock.automaticallyHideAndShowTheDock.enabled = true;

      # System Settings › Desktop & Dock › Dock › Show suggested and recent apps in Dock
      desktopAndDock.dock.showSuggestedAndRecentAppsInDock = false;

      # System Settings › Desktop & Dock › Desktop & Stage Manager › Show recent apps in Stage Manager
      desktopAndDock.desktopAndStageManager.showRecentAppsInStageManager = false;

      # System Settings › Desktop & Dock › Windows › Prefer tabs when opening documents
      desktopAndDock.windows.preferTabsWhenOpeningDocuments = "Never";

      # System Settings › Desktop & Dock › Windows › Drag windows to left or right edge of screen to tile
      desktopAndDock.windows.dragWindowsToLeftOrRightEdgeOfScreenToTile = false;

      # System Settings › Desktop & Dock › Windows › Drag windows to menu bar to fill screen
      desktopAndDock.windows.dragWindowsToMenuBarToFillScreen = false;

      # System Settings › Desktop & Dock › Windows › Hold ⌥ key while dragging windows to tile
      desktopAndDock.windows.holdOptionKeyWhileDraggingWindowsToTile = false;

      # System Settings › Desktop & Dock › Windows › Tiled windows have margins
      desktopAndDock.windows.tiledWindowsHaveMargins = true;

      # System Settings › Desktop & Dock › Mission Control › Automatically rearrange Spaces based on most recent use
      desktopAndDock.missionControl.automaticallyRearrangeSpacesBasedOnMostRecentUse = false;

      # System Settings › Desktop & Dock › Mission Control › Drag windows to top of screen to enter Mission Control
      desktopAndDock.missionControl.dragWindowsToTopOfScreenToEnterMissionControl = false;

      # --- Displays ---

      # System Settings › Displays › Advanced… › System Settings › Link to Mac or iPad › Allow your pointer and keyboard to move between any nearby Mac or iPad
      displays.universalControl.allowPointerAndKeyboardToMoveBetweenNearbyDevices = false;

      # System Settings › Displays › Advanced… › System Settings › Link to Mac or iPad › Push through the edge of a display to connect a nearby Mac or iPad
      # displays.universalControl.pushThroughTheEdgeOfADisplayToConnect = false;

      # --- Menu Bar ---

      # System Settings › Menu Bar › Recent documents, applications, and servers
      menuBar.recentDocumentsApplicationsAndServers = "None";

      # System Settings › Menu Bar › Show suggestions in Control Gallery
      menuBar.showSuggestionsInControlGallery = false;

      # System Settings › Menu Bar › Clock Options… › Show the day of the week
      menuBar.clock.showTheDayOfTheWeek = false;

      # System Settings › Menu Bar › Clock Options… › Style
      menuBar.clock.style = "Digital";

      # System Settings › Menu Bar › Clock Options… › Display the time with seconds
      menuBar.clock.displayTheTimeWithSeconds = true;

      # System Settings › Menu Bar › Menu Bar Controls › Battery Options… › Show Percentage
      menuBar.batteryOptions.showPercentage = true;

      # System Settings › Menu Bar › Menu Bar Controls › Focus
      menuBar.focusModes = "Don't Show";

      # System Settings › Menu Bar › Menu Bar Controls › Screen Mirroring
      menuBar.screenMirroring = "Don't Show";

      # System Settings › Menu Bar › Menu Bar Controls › Display
      menuBar.display = "Don't Show";

      # System Settings › Menu Bar › Menu Bar Controls › Sound
      menuBar.sound = "Always Show";

      # System Settings › Menu Bar › Menu Bar Controls › Now Playing
      menuBar.nowPlaying = "Don't Show";

      # System Settings › Menu Bar › Menu Bar Controls › Timer
      menuBar.timer = "Don't Show";

      # --- Spotlight ---

      # System Settings › Spotlight › Show Related Content
      spotlight.showRelatedContent = false;

      # System Settings › Spotlight › Help Apple Improve Search
      spotlight.helpAppleImproveSearch = false;

      # System Settings › Spotlight › Search results
      spotlight.searchResults = {
        apps = false;
        appStore = false;
        books = false;
        calculator = false;
        calendar = false;
        contacts = false;
        dictionary = false;
        files = false;
        folders = false;
        games = false;
        iPhoneApps = false;
        mail = false;
        menuItems = false;
        messages = false;
        music = false;
        notes = false;
        phone = false;
        photos = false;
        podcasts = false;
        reminders = false;
        safari = false;
        shortcuts = false;
        systemSettings = false;
        tips = false;
        voiceMemos = false;
      };

      # --- Wallpaper ---

      # System Settings › Wallpaper › Screen Saver… › Start Screen Saver…
      wallpaper.startScreenSaver = "After 1 hour";

      # --- Keyboard ---

      # System Settings › Keyboard › Key repeat rate
      keyboard.keyRepeatRate = 1;

      # System Settings › Keyboard › Delay until repeat
      keyboard.delayUntilRepeat = 25;

      # System Settings › Keyboard › Press 🌐︎ key to
      keyboard.pressGlobeKeyTo = "Do Nothing";

      # System Settings › Keyboard › Text Input › Input Sources › Edit… › Correct spelling automatically
      keyboard.textInput.correctSpellingAutomatically = false;

      # System Settings › Keyboard › Text Input › Input Sources › Edit… › Capitalize words automatically
      keyboard.textInput.capitalizeWordsAutomatically = false;

      # System Settings › Keyboard › Text Input › Input Sources › Edit… › Add period with double-space
      keyboard.textInput.addPeriodWithDoubleSpace = false;

      # --- Trackpad ---

      # System Settings › Trackpad › Point & Click › Tracking speed
      trackpad.pointAndClick.trackingSpeed = 1.5;

      # System Settings › Trackpad › Point & Click › Force Click and haptic feedback
      trackpad.pointAndClick.forceClickAndHapticFeedback = false;

      # System Settings › Trackpad › Point & Click › Look up & data detectors
      trackpad.pointAndClick.lookUpAndDataDetectors = "Off";

      # System Settings › Trackpad › Scroll & Zoom › Zoom in or out
      trackpad.scrollAndZoom.zoomInOrOut = false;

      # System Settings › Trackpad › Scroll & Zoom › Smart zoom
      trackpad.scrollAndZoom.smartZoom = false;

      # System Settings › Trackpad › Scroll & Zoom › Rotate
      trackpad.scrollAndZoom.rotate = false;

      # System Settings › Trackpad › More Gestures › Swipe between pages
      trackpad.moreGestures.swipeBetweenPages = "Off";

      # System Settings › Trackpad › More Gestures › Swipe between full-screen applications
      trackpad.moreGestures.swipeBetweenFullScreenApplications = "Off";

      # System Settings › Trackpad › More Gestures › Notification Center
      trackpad.moreGestures.notificationCenter = false;

      # System Settings › Trackpad › More Gestures › Mission Control
      trackpad.moreGestures.missionControl = "Off";

      # System Settings › Trackpad › More Gestures › App Exposé
      trackpad.moreGestures.appExpose = "Off";

      # System Settings › Trackpad › More Gestures › Show Desktop
      trackpad.moreGestures.showDesktop = false;
    };
  };
}
