{ pkgs, ... }:

{
	mobile.device.name = "furilabs-krypton";
	mobile.device.identity = {
		name = "Furiphone FLX1";
		manufacturer = "FuriLabs";
	};

	mobile.hardware = {
		soc = "mediatek-mt6877";
		ram = 1024 * 5.5;
		screen = {
			width = 1080; height = 2412;
		};
	};

	mobile.boot.stage-1 = {
		compression = "xz";
		kernel.package = pkgs.callPackage ./kernel { };

		# All important kernel modules seem to be set to `y`
		# modules = [];
	};

	mobile.device.firmware = pkgs.callPackage ./firmware {};

	mobile.system.android = {
		device_name = "krypton";
		ab_partitions = true;
		bootimg.flash = {
			offset_base = "0x10000000";
			offset_kernel = "0x00008000";
			offset_ramdisk = "0x01000000";
			offset_second = "0x00f00000";
			offset_tags = "0x00000100";
			pagesize = "4096";
		};
		appendDTB = [
			"dtbs/mediatek/mt6877.dtb"
		];
	};

	boot.kernelParams = [
		"bootopt=64S3,32N2,64N2"
		"androidboot.selinux=permissive"
    "buildvariant=userdebug"
		"console=ttyS0,921600n1"

	];

	mobile.system.type = "android";

	mobile.device.supportLevel = "supported";

	hardware.enableRedistributableFirmware = true;

	hardware.firmware = [
		pkgs.wireless-regdb # Required for WiFi >4
	];

	mobile.boot.serialConsole = "ttyS0,921600n1";

  # mobile.system.type = "u-boot";

  mobile.usb.mode = "gadgetfs";

  # Commonly re-used values, Nexus 4 (debug)
  mobile.usb.idVendor = "18d1";
  mobile.usb.idProduct = "d002";

	mobile.usb.gadgetfs.functions = {
		rndis = "rndis.usb0";
		mass_storage = "mass_storage.0";
		adb = "ffs.adb";
	};

	mobile.boot.stage-1.bootConfig = {
		storage.internal = "/dev/disk/by-path/platform-11230000.mmc";
	};
}
