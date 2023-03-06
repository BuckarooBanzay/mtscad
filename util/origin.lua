
local has_worldedit = minetest.get_modpath("worldedit")

local origin_map = {}
local hud_id_map = {}

local function display_origin(player)
    local playername = player:get_player_name()
    local origin = mtscad.get_origin(playername)
    if not origin then
        return
    end
    local text = "Origin: " .. minetest.pos_to_string(origin)

    if hud_id_map[playername] then
        -- update
        player:hud_change(hud_id_map[playername], "world_pos", origin)
        player:hud_change(hud_id_map[playername], "name", text)
    else
        -- create new
        hud_id_map[playername] = player:hud_add({
            hud_elem_type = "waypoint",
            name = text,
            text = "m",
            precision = 1,
            number = 0x0000FF,
            world_pos = origin
        })
    end
end

minetest.register_on_joinplayer(display_origin)
minetest.register_on_leaveplayer(function(player)
    hud_id_map[player:get_player_name()] = nil
end)

function mtscad.set_origin(playername, pos)
    if has_worldedit then
        worldedit.pos1[playername] = pos
        worldedit.mark_pos1(playername)
    else
        origin_map[playername] = pos
        local player = minetest.get_player_by_name(playername)
        if player then
            if not pos then
                origin_map[playername] = vector.round(player:get_pos())
            end
            display_origin(player)
        end
    end
end

function mtscad.get_origin(playername)
    if has_worldedit then
        return worldedit.pos1[playername]
    else
        return origin_map[playername]
    end
end