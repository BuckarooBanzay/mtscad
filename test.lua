
local function test_code(ctx)
    ctx
    :with({ name="default:stone" })
    :translate(10,10,10)
    :set()

    ctx
    :with({ name="default:stone" })
    :cube(10, 0, 0)
    :cube(0, 10, 0)
    :cube(0, 0, 10)
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