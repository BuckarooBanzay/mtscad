globals = {
	"mtscad",
	"minetest",
	"worldedit",
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
	"mtt"
}
