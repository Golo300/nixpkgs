import ../make-test-python.nix (
  { pkgs, ... }:
  {
    name = "basic test for stash app";

    nodes = {
      server =
        { config, pkgs, ... }:
        {
          services.stash = {
            enable = true;
            port = 1234;
          };
        };
    };

    testScript = ''
      start_all()

      # wait for service
      server.wait_for_unit("stash")
      server.succeed("systemctl is-active stash")

      # test port
      server.wait_for_open_port(1234)
    '';
  }
)
