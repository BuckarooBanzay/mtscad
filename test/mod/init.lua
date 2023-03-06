local pos1 = vector.new(0,0,0)
local pos2 = vector.new(30,30,30)

local MP = minetest.get_modpath("mtscad_test")
loadfile(MP .. "/util_merge.lua")()
loadfile(MP .. "/util_rotate_facedir.lua")()
loadfile(MP .. "/util_matrix.lua")()
loadfile(MP .. "/util_extents.lua")()
mtt.emerge_area(pos1, pos2)
loadfile(MP .. "/load_module.lua")({x=0, y=0, z=20})
loadfile(MP .. "/scale.lua")({x=20, y=20, z=0})
loadfile(MP .. "/draw_line.lua")({x=0, y=0, z=0})
loadfile(MP .. "/draw_async.lua")({x=20, y=0, z=0})
loadfile(MP .. "/translate_rotate.lua")({x=20, y=0, z=20})
loadfile(MP .. "/mirror.lua")({x=-20, y=0, z=20})
