{
  programs.nix-plist-manager = {
    enable = true;

    options.applications.systemSettings = {
      #--- Wi-Fi ---

      # System Settings › Wi‑Fi › Ask to join networks
      wiFi.askToJoinNetworks = "Off";

      # System Settings › Wi‑Fi › Ask to join hotspots
      wiFi.askToJoinHotspots = "Never";

      # --- Network ---

      # System Settings › Network › Firewall › Firewall
      network.firewall.firewall = true;

      # System Settings › Network › Firewall › Options… › Enable stealth mode
      network.firewall.options.enableStealthMode = true;

      # --- Battery ---

      # System Settings › Battery › Options… › Prevent automatic sleeping on power adapter when the display is off
      battery.options.preventAutomaticSleepingOnPowerAdapterWhenTheDisplayIsOff = true;

      # System Settings › Battery › Options… › Wake for network access
      battery.options.wakeForNetworkAccess = "Never";

      # --- General ---

      # System Settings › General › Software Update › Automatic Updates (i) › Download new updates when available
      general.softwareUpdate.automaticallyDownloadNewUpdatesWhenAvailable = false;

      # System Settings › General › Software Update › Automatic Updates (i) › Install macOS updates
      general.softwareUpdate.automaticallyInstallMacOSUpdates = false;

      # System Settings › General › Software Update › Automatic Updates (i) › Install system data files and security updates
      general.softwareUpdate.automaticallyInstallSystemDataFilesAndSecurityUpdates = false;

      # --- Lock Screen ---

      # System Settings › Lock Screen › Turn display off on battery when inactive
      lockScreen.turnDisplayOffOnBatteryWhenInactive = "For 30 minutes";

      # System Settings › Lock Screen › Turn display off on power adapter when inactive
      lockScreen.turnDisplayOffOnPowerAdapterWhenInactive = "For 1 hour, 30 minutes";
    };
  };
}
