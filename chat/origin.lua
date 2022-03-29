
minetest.register_chatcommand("origin", {
    func = function(name)
        mtscad.set_origin(name)
    end
})