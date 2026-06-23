{ delib, lib, ... }:

delib.module {
  name = "server";

  options = {
    server.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable server mode";
    };
  };

  myconfig.ifEnabled = { ... }: {
    shell.enable = true;
  };
}
