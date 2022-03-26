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

local function transform_axis(rel_pos, axis, angle)
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

    transform_axis(rel_pos, "x", rotation.x)
    transform_axis(rel_pos, "y", rotation.y)
    transform_axis(rel_pos, "z", rotation.z)

    return vector.add(origin, rel_pos)
end