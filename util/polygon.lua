
-- returns all crossings for a polygon on the given y-coordinate
-- docs: http://alienryderflex.com/polygon/
-- http://alienryderflex.com/polygon_fill/
function mtscad.get_polygon_crossings(points, y)
    -- x coords for crossings
    local crossings = {}

    local prev_p = points[#points]
    for _, curr_p in ipairs(points) do
        if (curr_p[2] < y and prev_p[2] >= y) or
            (prev_p[2] < y and curr_p[2] >= y) then
            -- x and y delta
            local xd = curr_p[1] - prev_p[1]
            local yd = curr_p[2] - prev_p[2]
            local d = xd / yd
            local yoffset = y - prev_p[2]
            local x = (yoffset * d) + prev_p[1]

            table.insert(crossings, x)
        end

        prev_p = curr_p
    end

    table.sort(crossings)
    return crossings
end

function mtscad.is_point_in_polygon(points, x, y)
    local crossings = mtscad.get_polygon_crossings(points, y)
    assert(#crossings % 2 == 0, "even crossing count: " .. #crossings .. " for point: " .. x .. "/" .. y)
    for i=1,#crossings,2 do
        local x1 = crossings[i]
        local x2 = crossings[i+1]

        if x >= x1 and x <= x2 then
            return true
        end
    end

    return false
end