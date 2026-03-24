{ delib, ... }:
delib.host {
  name = "nixlaptop";

  rice = "niri";
  type = "nixlaptop";

  myconfig = {
    programs = {
      wezterm.enable = true;
      telegram.enable = true;
      librewolf.enable = true;
      throne.enable = true;
      zed.enable = true;
      zen-browser.enable = true;
    };
  };

  home.home.stateVersion = "26.05";
  nixos.system.stateVersion = "26.05";

  nixos = {
    zramSwap.enable = true;
    time.timeZone = "Asia/Yekaterinburg";
  };
}
