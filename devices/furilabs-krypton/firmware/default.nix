{ lib
,runCommand
, firmwareLinuxNonfree
, fetchurl
}:

# Refer to:
# * https://github.com/FuriLabs/krypton-vendor-32 for vendor packaging on FuriOS
# * https://github.com/FuriLabs/krypton-modem-image for the modem packaging of FuriOS
# * https://filedump.furios.io for available downloads from vendor

# Modem is meant to be flashed to /dev/disk/by-partlabel/md1img_a, slot B is not used
# Vendor is to be flashed in /dev/mapper/dynpart-vendor_{a,b}

# FIXME(Krey): Likely also needs https://github.com/FuriLabs/mobile-broadband-provider-info ?

let
	modem-version = 1;
	vendor-version = 8;

	modem = fetchurl {
		url = "https://filedump.furios.io/krypton/modem-${modem-version}.img";
		# hash = "sha256-lTeyxzJNQeMdu1IVdovNMtgn77jRIhSybLdMbTkf2Ww=";
	};

	vendor = fetchurl {
		url = "https://filedump.furios.io/krypton/vendor-${vendor-version}.img";
		# hash = "sha256-lTeyxzJNQeMdu1IVdovNMtgn77jRIhSybLdMbTkf2Ww=";
	};

	# krypton-recovery = fetchurl
in runCommand "furilabs-krypton-firmware" {
	inherit modem vendor;
	src = firmwareLinuxNonfree;
	meta.license = lib.licenses.unfreeRedistributableFirmware;
} ''
	fwPath="$out/lib/firmware"
  mkdir -p "$fwPath"

	# Modem
	modemPath="$fwPath/krypton-modem-image"
	mkdir -p "$modemPath"
  cp -vr "$modem" "$modemPath/"

	# Vendor
	modemPath="$fwPath/krypton-vendor-image"
	mkdir -p "$vendorPath"
  cp -vr "$vendor" "$vendorPath/"
''
