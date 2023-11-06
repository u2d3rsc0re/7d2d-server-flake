{
    lib,
    buildFHSUserEnv,
    writeScript,
    _7d2d-server-unwrapped,
    steamworks-sdk-redist,
}:
buildFHSUserEnv {
    name = "_7d2d-server";

    runScript = "_7d2d-server-executable";

    targetPkgs = pkgs: [
        _7d2d-server-unwrapped
        steamworks-sdk-redist
    ];

    inherit (_7d2d-server-unwrapped) meta;
}
