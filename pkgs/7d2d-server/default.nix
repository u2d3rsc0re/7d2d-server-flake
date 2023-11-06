{
    lib,
    stdenv,
    fetchSteam,
}:
stdenv.mkDerivation rec {
    name = "_7d2d-server";
    version = "A21.1";
    src = fetchSteam {
        inherit name;
        appId = "294420";
        depotId = "294422";
        manifestId = "4485042179748822610";
        hash = "";
    };

    dontBuild = true;
    dontConfigure = true;
    dontFixup = true;

    installPhase = ''
        runHook preInstall

        mkdir -p $out
        cp -r \
        7DaysToDieServer_Data \
        Data \
        7DaysToDieServer.x86_64 \
        libstdc++.so.6 \
        Licenses \
        Logos \
        Mods \
        platform.cfg \
        steamclient.so \
        UnityPlayer.so \
        serverconfig.xml \
        $out

        chmod +x $out/7DaysToDieServer.x86_64

        runHook postInstall
    '';

    meta = with lib; {
        description = "Dedicated 7 Days to Die Server";
        homepage = "https://steamdb.info/app/294420";
        changelog = "https://store.steampowered.com/news/app/294420?updates=true";
        sourceProvenance = with sourceTypes; [
            binaryNativeCode
            binaryBytecode
        ];
        license = licenses.unfree;
        platforms = ["x86_64-linux"];
    };
}
