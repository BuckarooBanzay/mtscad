
function mtscad.Context:polygon(points, fill)
    local min_x, max_x = points[1][1], points[1][1]
    local min_y, max_y = points[1][2], points[1][2]

    for i=2, #points do
        local p1 = points[i-1]
        local p2 = points[i]

        min_x = math.min(min_x, p2[1])
        min_y = math.min(min_y, p2[2])
        max_x = math.max(max_x, p2[1])
        max_y = math.max(max_y, p2[2])

        local p1_pos = vector.new(p1[1], p1[2], 0)
        local p2_pos = vector.new(p2[1], p2[2], 0)

        local rel_p2 = vector.subtract(p2_pos, p1_pos)

        self
        :translate(p1[1], p1[2], 0)
        :line(rel_p2.x, rel_p2.y, 0)
    end

    if fill and max_y > min_y+1 and max_x > min_x+1 then
        -- fill specified and area non-zero
        for y=min_y+1,max_y-1 do
            local crossings = mtscad.get_polygon_crossings(points, y)
            for i=1,#crossings,2 do
                local x1 = crossings[i]
                local x2 = crossings[i+1]

                self
                :translate(x1, y, 0)
                :line(x2-x1, y, 0)
            end
        end
    end

    return self
end