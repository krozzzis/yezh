{ delib, ... }:
delib.host {
  name = "pi-backup";

  nixos.always =
    { config, myconfig, ... }:
    let
      inherit (myconfig.user.constants) username;
    in
    {
      sops = {
        defaultSopsFile = ./secrets.yaml;
        # Dedicated per-host age key rather than deriving from the SSH host
        # key: the SSH host key doesn't exist until first boot, which would
        # make the very first activation (the one that needs to set the
        # login password and authorized key) unable to decrypt anything.
        # This file has to be copied onto the SD card out-of-band, at
        # /var/lib/sops-nix/key.txt (mode 600), before first boot.
        age.keyFile = "/var/lib/sops-nix/key.txt";

        secrets = {
          password.neededForUsers = true;
          ssh_pubkey = { };
        };
      };

      users.users.${username}.hashedPasswordFile = config.sops.secrets.password.path;

      # authorizedKeys.keyFiles reads its target at build time, which can't
      # work for a path that only exists at runtime after sops decrypts it.
      # authorizedKeysFiles is read by sshd per-connection instead.
      services.openssh.authorizedKeysFiles = [ config.sops.secrets.ssh_pubkey.path ];
    };
}
