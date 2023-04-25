
mtscad = {}

local MP = minetest.get_modpath("mtscad")
-- context fn
dofile(MP .. "/context/new.lua")
dofile(MP .. "/context/with.lua")
dofile(MP .. "/context/set_node.lua")
dofile(MP .. "/context/execute.lua")
dofile(MP .. "/context/translate.lua")
dofile(MP .. "/context/rotate.lua")
dofile(MP .. "/context/line.lua")
dofile(MP .. "/context/polygon.lua")
dofile(MP .. "/context/cube.lua")
dofile(MP .. "/context/sphere.lua")
dofile(MP .. "/context/dome.lua")
dofile(MP .. "/context/cylinder.lua")
dofile(MP .. "/context/pattern.lua")
dofile(MP .. "/context/char.lua")
dofile(MP .. "/context/text.lua")
dofile(MP .. "/context/mirror.lua")

-- utilities
dofile(MP .. "/util/extents.lua")
dofile(MP .. "/util/matrix.lua")
dofile(MP .. "/util/origin.lua")
dofile(MP .. "/util/polygon.lua")
dofile(MP .. "/util/rotate_facedir.lua")
dofile(MP .. "/util/transform.lua")
dofile(MP .. "/util/merge.lua")
dofile(MP .. "/util/load_module.lua")
dofile(MP .. "/util/job_context.lua")

-- chatcommands
dofile(MP .. "/chat/load.lua")
dofile(MP .. "/chat/origin.lua")

-- charsets
dofile(MP .. "/charsets/8x8.lua")

if minetest.get_modpath("mtt") and mtt.enabled then
    -- test utils
    dofile(MP .. "/util/extents.spec.lua")
    dofile(MP .. "/util/matrix.spec.lua")
    dofile(MP .. "/util/rotate_facedir.spec.lua")
    dofile(MP .. "/util/merge.spec.lua")
    dofile(MP .. "/util/polygon.spec.lua")

    -- test context
    mtt.emerge_area({x=0, y=0, z=0}, {x=48, y=48, z=48})
    loadfile(MP .. "/spec/draw_async.spec.lua")({x=20, y=0, z=0})
    loadfile(MP .. "/spec/load_module.spec.lua")({x=0, y=0, z=20})
    loadfile(MP .. "/spec/draw_line.spec.lua")({x=0, y=0, z=0})
    loadfile(MP .. "/spec/draw_polygon.spec.lua")({x=0, y=10, z=10})
    loadfile(MP .. "/spec/translate_rotate.spec.lua")({x=20, y=0, z=20})
    loadfile(MP .. "/spec/mirror.spec.lua")({x=-20, y=0, z=20})
end
