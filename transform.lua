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

-- https://github.com/minetest/minetest/pull/11932 / https://github.com/aerkiaga
-- Map each facedir to the result of applying
-- right-hand rotation around y+ or z+ vector
local rotated_facedir_map = {
	["y+"] = {
		[0] = 3, 0, 1, 2,
		19, 16, 17, 18,
		15, 12, 13, 14,
		7, 4, 5, 6,
		11, 8, 9, 10,
		21, 22, 23, 20
	},
	["z+"] = {
		[0] = 12, 13, 14, 15,
		7, 4, 5, 6,
		9, 10, 11, 8,
		20, 21, 22, 23,
		0, 1, 2, 3,
		16, 17, 18, 19,
	},
}

-- Map rotations on all 6 orthogonal vectors to
-- rotations around just y+ and z+
local vector_lambda_map = {
	["x+"] = function (f, r, x)
		return f(3, "y+", f(r, "z+", f(1, "y+", x))) end,
	["x-"] = function (f, r, x)
		return f(1, "y+", f(r, "z+", f(3, "y+", x))) end,
	["y+"] = function (f, r, x)
		return f(r, "y+", x) end,
	["y-"] = function (f, r, x)
		return f(4 - r, "y+", x) end,
	["z+"] = function (f, r, x)
		return f(r, "z+", x) end,
	["z-"] = function (f, r, x)
		return f(4 - r, "z+", x) end,
}

local function rotate_facedir(rotation, vector_name, facedir)
	facedir = facedir or 0
	local function lookup_function(r, n, x)
		if r == 0 then return x end
		return lookup_function(r - 1, n, rotated_facedir_map[n][x])
	end
	local translation_function = vector_lambda_map[vector_name]
		or function () return nil end
	return translation_function(lookup_function, rotation % 4, facedir)
end

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
            node.param2 = rotate_facedir(math.floor(angle / 90), axis, node.param2)

        end
    end

end

function mtscad.transform_node(node, rotation)
    local tnode = { name=node.name, param1=node.param1, param2=node.param2 }
    transform_node_axis(tnode, "x-", rotation.x)
    transform_node_axis(tnode, "y-", rotation.y)
    transform_node_axis(tnode, "z-", rotation.z)
    return tnode
end