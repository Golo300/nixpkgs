{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.services.stash;
in
{
  options = {

    services.stash = {

      enable = mkOption {
        type = lib.types.bool;
        default = false;
        description = "a stash instance";
      };
      configFile = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Path to the configuration file to use.";
      };

      cpuProfile = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Path to the file where CPU profile will be written.";
      };

      host = lib.mkOption {
        type = lib.types.str;
        default = "0.0.0.0";
        description = "IP address for the host.";
      };

      noBrowser = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Don't open a browser window after launch.";
      };

      port = lib.mkOption {
        type = lib.types.int;
        default = 9999;
        description = "Port to serve from.";
      };
    };
  };
   config = mkIf cfg.enable {
    systemd.services.stash = {
      description = "Stash Service";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        ExecStart = ''
          ${pkgs.stash}/bin/stash \
            ${optionalString (cfg.configFile != "") "-c ${cfg.configFile}"} \
            ${optionalString (cfg.cpuProfile != "") "--cpuprofile ${cfg.cpuProfile}"} \
            --host ${cfg.host} \
            ${optionalString cfg.noBrowser "--nobrowser"} \
            --port ${toString cfg.port}
        '';
        Restart = "always";
        RestartSec = "5s";
      };
    };
   };
}
