{ delib, lib, pkgs, inputs, ... }:
delib.module {
  name = "programs.gui.apps.walker";

  options = { myconfig, ... }: {
    programs.gui.apps.walker.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
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
