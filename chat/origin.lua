
minetest.register_chatcommand("scad_origin", {
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if player then
            local pos = vector.round(player:get_pos())
            mtscad.set_origin(name, pos)
            return true, "Origin set to " .. minetest.pos_to_string(pos)
        end
    end
})