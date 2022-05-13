-- TODO: attribute worledit code

local function get_axis_others(axis)
    if axis == "x" then
        return "y", "z"
    elseif axis == "y" then
        return "x", "z"
    elseif axis == "z" then
        return "x", "y"
    else
        error("Axis must be x, y, or z!")
    end
end

local function flip_pos(rel_pos, axis)
    rel_pos[axis] =  -1 * rel_pos[axis]
end

local function transpose_pos(rel_pos, axis1, axis2)
    rel_pos[axis1], rel_pos[axis2] = rel_pos[axis2], rel_pos[axis1]
end

local function transform_pos_axis(rel_pos, axis, angle)
    local other1, other2 = get_axis_others(axis)
    angle = angle % 360

    if angle == 0 then
        return
    elseif angle == 90 then
        flip_pos(rel_pos, other1)
        transpose_pos(rel_pos, other1, other2)
    elseif angle == 180 then
        flip_pos(rel_pos, other1)
        flip_pos(rel_pos, other2)
    elseif angle == 270 then
        flip_pos(rel_pos,other2)
        transpose_pos(rel_pos, other1, other2)
    else
        error("Only 90 degree increments are supported!")
    end
end

function mtscad.transform_pos(origin, pos, rotation)
    local rel_pos = vector.subtract(pos, origin)

    transform_pos_axis(rel_pos, "y", rotation.y)
    transform_pos_axis(rel_pos, "z", rotation.z)
    transform_pos_axis(rel_pos, "x", rotation.x)

    return vector.add(origin, rel_pos)
end

local wallmounted = {
    [90]  = {0, 1, 5, 4, 2, 3, 0, 0},
    [180] = {0, 1, 3, 2, 5, 4, 0, 0},
    [270] = {0, 1, 4, 5, 3, 2, 0, 0}
}

local function transform_node_axis(node, axis, angle)
    angle = angle % 360
    if angle == 0 then
        return 0
    end
    if angle % 90 ~= 0 then
        error("Only 90 degree increments are supported!")
    end

    local wallmounted_substitution = wallmounted[angle]
    local def = minetest.registered_nodes[node.name]
    if def then
        local paramtype2 = def.paramtype2
        if (paramtype2 == "wallmounted" or paramtype2 == "colorwallmounted") and axis == "y+" then
            local orient = node.param2 % 8
            node.param2 = node.param2 - orient +
                    wallmounted_substitution[orient + 1]

        elseif paramtype2 == "facedir" or paramtype2 == "colorfacedir" then
            node.param2 = mtscad.rotate_facedir(math.floor(angle / 90), axis, node.param2)

        end
    end

end

function mtscad.transform_node(node, rotation)
    local tnode = { name=node.name, param1=node.param1, param2=node.param2 }
    transform_node_axis(tnode, "y-", rotation.y)
    transform_node_axis(tnode, "z+", rotation.z)
    transform_node_axis(tnode, "x+", rotation.x)
    return tnode
end