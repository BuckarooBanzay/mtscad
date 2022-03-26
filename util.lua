local function flip_pos(rel_pos, axis)
	rel_pos[axis] =  -1 * rel_pos[axis]
end

local function transpose_pos(rel_pos, axis1, axis2)
	rel_pos[axis1], rel_pos[axis2] = rel_pos[axis2], rel_pos[axis1]
end

function mtscad.transform_pos(origin, pos, rotation)
    -- TODO: verify max-pos
    local rel_pos = vector.subtract(pos, origin)
    if rotation.y == 90 then
        flip_pos(rel_pos, "z")
		transpose_pos(rel_pos, "x", "z")
    elseif rotation.y == 180 then
        flip_pos(rel_pos, "x")
        flip_pos(rel_pos, "z")
    elseif rotation.y == 270 then
        flip_pos(rel_pos, "x")
        transpose_pos(rel_pos, "x", "z")
    end
    -- TODO
    return vector.add(origin, rel_pos)
end