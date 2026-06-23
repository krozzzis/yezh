{ delib, lib, ... }:

delib.module {
  name = "desktop";

  options = { myconfig, ... }: {
    desktop.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable desktop/PC mode (meta-option enabling gui and shell)";
    };
  };

  myconfig.ifEnabled = { ... }: {
    gui.enable = true;
    shell.enable = true;

    system.ntfs.enable = false;

    programs.network.yggdrasil.enable = true;

  };
}
