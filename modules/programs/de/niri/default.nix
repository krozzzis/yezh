{ delib, inputs, pkgs, ... }:
delib.module {
  name = "programs.niri";

  options = delib.singleEnableOption false;

  nixos.always.imports = [ inputs.niri.nixosModules.niri ];

  nixos.ifEnabled = {
    programs.niri.enable = true;
    nixpkgs.overlays = [ inputs.niri.overlays.niri ];
    programs.niri.package = pkgs.niri-unstable;

    # use the gnome polkit rather than the kde one installed
    # by default with the niri flake
    systemd.user.services.niri-flake-polkit.enable = false;

    environment.variables.NIXOS_OZONE_WL = "1";

    environment.systemPackages = with pkgs; [
      xwayland-satellite
      wayland-utils
      libnotify
      brightnessctl
      networkmanagerapplet
      pamixer
      pulsemixer
      pavucontrol
      wtype
    ];

  };

}
