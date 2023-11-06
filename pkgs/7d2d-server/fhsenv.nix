{
    buildFHSUserEnv,
    _7d2d-server-unwrapped,
    steamworks-sdk-redist,
}:
buildFHSUserEnv {
    name = "_7d2d-server";

    runScript = "7DaysToDieServer.x86_64";

    targetPkgs = pkgs: [
        _7d2d-server-unwrapped
        steamworks-sdk-redist
    ];

    inherit (_7d2d-server-unwrapped) meta;
}
