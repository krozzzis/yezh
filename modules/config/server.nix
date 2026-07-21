{ delib, lib, ... }:

delib.module {
  name = "server";

  options = {
    server.enable = delib.description (delib.boolOption false) "Enable server mode";
  };

  myconfig.ifEnabled = { ... }: {
    shell.enable = true;
  };
}
