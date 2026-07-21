{ delib, lib, ... }:

delib.module {
  name = "desktop";

  options = { myconfig, ... }: {
    desktop.enable = delib.description (delib.boolOption false) "Enable desktop/PC mode (meta-option enabling gui and shell)";
  };

  myconfig.ifEnabled = { ... }: {
    gui.enable = true;
    shell.enable = true;

    system.ntfs.enable = false;
  };
}
