{
  mobile-nixos
, fetchFromGitLab
, buildPackages
, ...
}:
let
  inherit (buildPackages) dtc;
in mobile-nixos.kernel-builder {
  version = "4.19.325";
  configfile = ./config.aarch64;

  src = fetchFromGitLab {
    owner = "FuriLabs";
    repo = "linux-furiphone-krypton";
    rev = "forky";
    # sha256 = "sha256-5o+zeJ6+c6hJTaK1m9KfcvN61aqKBs6+mk87nAkyFwY=";
  };

  patches = [];

	makeFlags = [
    "DTC_EXT=${dtc}/bin/dtc"
  ];

  postInstall = ''
    echo ":: Installing FDTs"
    mkdir -p $out/dtbs/mediatek
    cp -v "$buildRoot/arch/arm64/boot/dts/mediatek/mt6877.dtb" "$out/dtbs/mediatek/"
  '';

  isModular = false;
  isCompressed = false;
}
