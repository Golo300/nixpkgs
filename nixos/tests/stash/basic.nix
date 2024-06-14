import ../make-test-python.nix ({ pkgs, ... }: {
    name = "basic test for stash app";

    nodes = {
      machine1 = { config, pkgs, ... }: {
        services.stash.enable = true;
      };

      machine2 = { config, pkgs, ... }: {
      };
    };

    testScript = ''
      start_all()

      machine1.succeed("echo this runs on machine1")
      machine2.succeed("echo this runs on machine2")
      ...
    '';
  })

