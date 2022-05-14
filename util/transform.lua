
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
        print(angle)
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
    transform_node_axis(tnode, "y-", mtscad.matrix_angle_y(rotation))
    transform_node_axis(tnode, "z+", mtscad.matrix_angle_z(rotation))
    transform_node_axis(tnode, "x+", mtscad.matrix_angle_x(rotation))
    return tnode
end