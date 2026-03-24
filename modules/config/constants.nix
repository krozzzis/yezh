{ delib, ... }:
delib.module {
  name = "constants";

  options.constants = with delib; {
    username = readOnly (strOption "krozzzis");
    userfullname = readOnly (strOption "Nikita Shumov");
    useremail = readOnly (strOption "schumov.nn@gmail.com");
  };
}
