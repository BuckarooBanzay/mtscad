globals = {
	"mtscad",
	"minetest",
	"vector" -- for test-env patching
}

read_globals = {
	-- Stdlib
	string = {fields = {"split", "trim"}},
	table = {fields = {"copy", "getn"}},

	-- Minetest
	"ItemStack",
	"dump", "dump2",
	"VoxelArea",

	-- deps
	"worldedit",

	-- testing
	"mineunit", "sourcefile", "assert", "describe", "it"
}
