{ lib
, runCommand
, linux-firmware
}:

# The minimum set of firmware files required for the family

runCommand "mt8173-chromeos-firmware" {
	src = linux-firmware;
	meta.license = linux-firmware.meta.license;
} ''
  for firmware in \
    mrvl/* \
    mrvl/*/* \
    mediatek/* \
		mediatek/*/*
    powervr/* \
  ; do
    mkdir -p "$(dirname $out/lib/firmware/$firmware)"
    cp -vrf "$src/lib/firmware/$firmware" $out/lib/firmware/$firmware
  done
''

# (builtins.concatStringsSep "/n" [
# 		"for firmware in"
# 			# FIXME-QA(Krey): This can probably be optimized, but it's what pmos is using through alpine..
# 				"mrvl/*"
# 				"mrvl/*/*"

# 				"./mediatek/*"
# 				"./mediatek/*/*"

# 				"./powervr/*"
# 			"; do"
# 				"mkdir -p \"$(dirname $out/lib/firmware/$firmware)\""
# 				"cp -vrf \"$src/lib/firmware/$firmware\" $out/lib/firmware/$firmware"
# 			"done"
# ])
