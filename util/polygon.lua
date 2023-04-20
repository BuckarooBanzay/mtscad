
-- returns all crossings for a polygon on the given y-coordinate
-- docs: http://alienryderflex.com/polygon/
function mtscad.get_polygon_crossings(points, y)
    -- x coords for crossings
    local crossings = {}

    local prev_p = points[#points]
    for _, curr_p in ipairs(points) do
        if (curr_p[2] < y and prev_p[2] >= y) or
            (prev_p[2] < y and curr_p[2] >= y) then
            -- crosses the y-line
            local x_spread = curr_p[1] - prev_p[1]
            local y_spread = math.abs(curr_p[2] - prev_p[2])
            local y_factor = (y - math.min(prev_p[2], curr_p[2])) / y_spread

            if y_factor == 0 then
                table.insert(crossings, curr_p[1])
            else
                table.insert(crossings, x_spread * y_factor)
            end
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