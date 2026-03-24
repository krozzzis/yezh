{ delib, inputs, ... }:
delib.module {
  name = "programs.noctalia";

  options = delib.singleEnableOption false;

  home.always.imports = [ inputs.noctalia.homeModules.default ];
  nixos.always.imports = [ inputs.noctalia.nixosModules.default ];

  home.ifEnabled = { myconfig, ...}: {
    programs.noctalia-shell = {
      enable = true;
      settings = {
        # configure noctalia here
        bar = {
          density = "compact";
          position = "right";
          showCapsule = false;
          widgets = {
            left = [
              {
                id = "ControlCenter";
                useDistroLogo = true;
              }
              {
                id = "Tray";
                colorizeIcons = true;
                drawerEnabled = false;
              }
            ];
            center = [
              {
                hideUnoccupied = false;
                id = "Workspace";
                labelMode = "none";
              }
            ];
            right = [
              {
                id = "KeyboardLayout";
                displayMode = "alwaysShow";
                showIcon = false;
              }
              {
                id = "Volume";
                displayMode = "alwaysShow";
              }
              {
                id = "Network";
              }
              {
                id = "Bluetooth";
              }
              {
                alwaysShowPercentage = true;
                id = "Battery";
                warningThreshold = 25;
              }
              {
                formatHorizontal = "HH:mm";
                formatVertical = "HH mm";
                id = "Clock";
                useMonospacedFont = true;
                usePrimaryColor = true;
              }
            ];
          };
        };
        dock = {
          enable = false;
        };
        colorSchemes.predefinedScheme = "Monochrome";
        general = {
          avatarImage = "/home/${myconfig.constants.username}/.face.png";
          radiusRatio = 1;
          iRadiusRatio = 1;
          enableShadows = false;
        };
        location = {
          monthBeforeDay = true;
          name = "Yekaterinburg, Russia";
        };
      };
      # this may also be a string or a path to a JSON file.
    };
  };

  nixos.ifEnabled = {
    services.noctalia-shell.enable = true;
    services.upower.enable = true;
  };
}
