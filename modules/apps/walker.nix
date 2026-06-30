{ delib, lib, pkgs, inputs, ... }:
delib.module {
  name = "apps.walker";

  options = { myconfig, ... }: {
    apps.walker.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    apps.walker.pkg = lib.mkOption {
      type = lib.types.package;
      default = inputs.walker.packages.${pkgs.stdenv.hostPlatform.system}.default or pkgs.walker;
    };
  };

  nixos.always.nix.settings = {
    extra-substituters = ["https://walker.cachix.org" "https://walker-git.cachix.org"];
    extra-trusted-public-keys = ["walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM=" "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="];
  };

  home.always.imports = [inputs.walker.homeManagerModules.default];

  home.ifEnabled = {
    programs.walker = {
      enable = true;
      runAsService = true;
    };

    programs.elephant.enable = true;

    home.activation.restartElephant = ''
      systemctl --user try-restart elephant.service 2>/dev/null || true
      ${pkgs.elephant}/bin/elephant index 2>/dev/null || true
    '';

    # systemd.user.services.elephant = {
    #   Unit = {
    #     Description = "Elephant";
    #     After = [ "graphical-session.target" ];
    #   };

    #   Service = {
    #     Type = "simple";
    #     ExecStart = "${pkgs.elephant}/bin/elephant";
    #     Restart = "on-failure";
    #   };

    #   Install = {
    #     WantedBy = [ "graphical-session.target" ];
    #   };
    # };
  };
}
