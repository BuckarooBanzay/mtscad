

local function axis_extent(min, max, pos, axis)
    if pos[axis] < min[axis] then min[axis] = pos[axis] end
    if pos[axis] > max[axis] then max[axis] = pos[axis] end
end

-- returns the new min/max positions
function mtscad.extents(min, max, pos)
    axis_extent(min, max, pos, "x")
    axis_extent(min, max, pos, "y")
    axis_extent(min, max, pos, "z")
end