-- TODO: attribute worledit code

function mtscad.sort_pos(pos1, pos2)
	pos1 = {x=pos1.x, y=pos1.y, z=pos1.z}
	pos2 = {x=pos2.x, y=pos2.y, z=pos2.z}
	if pos1.x > pos2.x then
		pos2.x, pos1.x = pos1.x, pos2.x
	end
	if pos1.y > pos2.y then
		pos2.y, pos1.y = pos1.y, pos2.y
	end
	if pos1.z > pos2.z then
		pos2.z, pos1.z = pos1.z, pos2.z
	end
	return pos1, pos2
end

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

    transform_pos_axis(rel_pos, "x", rotation.x)
    transform_pos_axis(rel_pos, "y", rotation.y)
    transform_pos_axis(rel_pos, "z", rotation.z)

    return vector.add(origin, rel_pos)
end

local wallmounted = {
    [90]  = {0, 1, 5, 4, 2, 3, 0, 0},
    [180] = {0, 1, 3, 2, 5, 4, 0, 0},
    [270] = {0, 1, 4, 5, 3, 2, 0, 0}
}
local facedir = {
    [90]  = { 1,  2,  3,  0, 13, 14, 15, 12, 17, 18, 19, 16,
              9, 10, 11,  8,  5,  6,  7,  4, 23, 20, 21, 22},
    [180] = { 2,  3,  0,  1, 10, 11,  8,  9,  6,  7,  4,  5,
             18, 19, 16, 17, 14, 15, 12, 13, 22, 23, 20, 21},
    [270] = { 3,  0,  1,  2, 19, 16, 17, 18, 15, 12, 13, 14,
              7,  4,  5,  6, 11,  8,  9, 10, 21, 22, 23, 20}
}

local function transform_pos_node(node, _, angle)
	angle = angle % 360
	if angle == 0 then
		return 0
	end
	if angle % 90 ~= 0 then
		error("Only 90 degree increments are supported!")
	end

    local wallmounted_substitution = wallmounted[angle]
	local facedir_substitution = facedir[angle]
    local def = minetest.registered_nodes[node.name]
    if def then
        local paramtype2 = def.paramtype2
        if paramtype2 == "wallmounted" or
                paramtype2 == "colorwallmounted" then
            local orient = node.param2 % 8
            node.param2 = node.param2 - orient +
                    wallmounted_substitution[orient + 1]
        elseif paramtype2 == "facedir" or
                paramtype2 == "colorfacedir" then
            local orient = node.param2 % 32
            node.param2 = node.param2 - orient +
                    facedir_substitution[orient + 1]
        end
    end

end

function mtscad.transform_node(node, rotation)
    local tnode = { name=node.name, param1=node.param1, param2=node.param2 }
    transform_pos_node(tnode, "y", rotation.y)
    return tnode
end