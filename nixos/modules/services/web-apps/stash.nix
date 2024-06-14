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
        type = types.bool;
        default = false;
        description = "a stash instance";
      };
    };
  };
}
