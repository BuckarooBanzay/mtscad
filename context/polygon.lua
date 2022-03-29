
function mtscad.Context:polygon(points)
    for i=2, #points do
        local p1 = points[i-1]
        local p2 = points[i]
        local p1_pos = vector.new(p1[1], p1[2], p1[3])
        local p2_pos = vector.new(p2[1], p2[2], p2[3])

        local rel_p2 = vector.subtract(p2_pos, p1_pos)

        self
        :translate(p1[1], p1[2], p1[3])
        :line(rel_p2.x, rel_p2.y, rel_p2.z)
    end
    return self
end