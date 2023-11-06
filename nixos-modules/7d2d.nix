{
    self,
    steam-fetcher,
}: {
    config,
    pkgs,
    lib,
    ...
}: let
    cfg = config.services."7d2d";
in {
    config.nixpkgs.overlays = [self.overlays.default steam-fetcher.overlays.default];

    options.services."7d2d" = {
        enable = lib.mkEnableOption (lib.mdDoc "7 Days to Die Dedicated Server");
    };

    config = {
        users = {
            users."7d2d" = {
                isSystemUser = true;
                group = "7d2d";
                home = "/var/lib/7d2d";
            };
            groups."7d2d" = {};
        };

        systemd.services."7d2d" = {
            description = "7 Days to Die dedicated server";
            requires = ["network.target"];
            after = ["network.target"];
            wantedBy = ["multi-user.target"];

            serviceConfig = {
                type = "exec";
                user = "7d2d";
                ExecStart = "${pkgs._7d2d-server}/7DaysToDieServer.x86_64 -logfile /var/log/7d2d/output_log__`date +%Y-%m-%d__%H-%M-%S`.txt -quit -batchmode -nographics -dedicated -configfile=${pkgs._7d2d-server}/serverconfig.xml";
            };
        };
    };
}
