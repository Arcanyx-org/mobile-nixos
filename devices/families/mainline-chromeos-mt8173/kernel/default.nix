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
		sha256 = "sha256-F1vg95nMGiXk9zbUzg+/hUq+RjXdFmtN530b7QuqkMc=";
	};

	patches = [];

	isModular = true;
	isCompressed = false;
}
