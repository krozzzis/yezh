{ delib, lib, ... }:

delib.module {
  name = "user.server";

  options = {
    user.server.enable = delib.description (delib.boolOption false) "Enable server mode";
  };

  myconfig.ifEnabled = { ... }: {
    user.shell.enable = true;
  };
}
