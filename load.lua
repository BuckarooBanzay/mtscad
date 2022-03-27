
local path = minetest.get_worldpath() .. "/mtscad"
minetest.mkdir(path)

minetest.register_chatcommand("scad", {
    func = function(name, filename)
        local def, load_err = loadfile(path .. "/" .. filename)
        if not def then
            return false, "Loading failed with '" .. load_err .. "'"
        end

        local player = minetest.get_player_by_name(name)
        local ppos = player:get_pos()
        local ctx = mtscad.create_context(vector.round(ppos))

        local success, exec_err = pcall(function()
            local fn = def()
            fn(ctx)
        end)

        if not success then
            return false, "Execute failed with '" ..exec_err .. "'"
        end

        return true, "File successfully executed"
    end
})