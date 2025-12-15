{ config, lib, pkgs, ... }:

{
	imports = [
		../families/mainline-chromeos-mt8173
	];

	mobile.device.name = "lenovo-hana";
	mobile.device.identity = {
		name = "Chromebook e300";
		manufacturer = "Lenovo";
	};
	mobile.device.supportLevel = "supported";
	mobile.hardware = {
		screen = {
			width = 1366; height = 768;
		};
	};
}
