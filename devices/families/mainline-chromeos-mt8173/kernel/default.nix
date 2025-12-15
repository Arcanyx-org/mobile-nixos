{
	mobile-nixos
, fetchFromGitHub
, fetchpatch
, ...
}:

mobile-nixos.kernel-builder {
	version = "6.18.0";
	configfile = ./config.aarch64;

	src = fetchFromGitHub {
		owner = "torvalds";
		repo = "linux";
		rev = "v6.18";
		# sha256 = "sha256-PQjXBWJV+i2O0Xxbg76HqbHyzu7C0RWkvHJ8UywJSCw=";
	};

	patches = [];

	isModular = true;
	isCompressed = false;
}
