
minetest.register_chatcommand("scad_origin", {
    func = function(name)
        mtscad.set_origin(name)
    end
})