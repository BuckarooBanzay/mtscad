
local function rot_test(ctx)
    ctx
    :with({ name="wool:red" })
    :cube(10,1,1)
    :with({ name="wool:blue" })
    :rotate(0,90,0)
    :cube(10,1,1)
    :with({ name="wool:green" })
    :rotate(0,90,0)
    :cube(10,1,1)
    :with({ name="wool:yellow" })
    :rotate(0,90,0)
    :cube(10,1,1)
    :translate(10,0,0)
    :with({ name="moreblocks:slope_stone" })
    :slope({ x=1, y=1, z=0 })
    :set_node()
end

local function test_code(ctx)
    ctx
    :with({ name="default:stone" })
    :cube(10, 1, 1)
    :cube(1, 10, 1)
    :cube(1, 1, 10)

    ctx
    :translate(10, 10, 10)
    :execute(rot_test)

    ctx
    :with({ name="default:copperblock" })
    :translate(2,2,2)
    :grid(5, 5, 5)
end

minetest.register_chatcommand("test", {
    func = function(name)
        local player = minetest.get_player_by_name(name)
        local ppos = player:get_pos()
        local ctx = mtscad.create_context(vector.round(ppos))
        test_code(ctx)
    end
})

--[[
ctx
:translate(0, 0, 0)
:rotate(0, 0, 0)
:cube(0, 10, 0)

ctx
:translate(0, 0, 0)
:rotate(0, 0, 0)
:apply(function(ctx)
    ctx:cube(0, 10, 0)
    ctx:cube(0, 0, 10)
end)
--]]