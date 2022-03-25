
local function test_code(ctx)
    ctx:set_nodename("default:stone")
    ctx:line("x", 10)
    ctx:line("y", 10)
    ctx:line("z", 10)
end

minetest.register_chatcommand("test", {
    func = function(name)
        local player = minetest.get_player_by_name(name)
        local ppos = player:get_pos()
        local ctx = mtscad.create_context(vector.round(ppos))
        test_code(ctx)
    end
})