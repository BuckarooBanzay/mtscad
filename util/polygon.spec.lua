
mtt.register("get_polygon_crossings", function(callback)
    local points = {
        -- x, y (triangle)
        {0,0},
        {0,10},
        {10,0}
    }

    local crossings = mtscad.get_polygon_crossings(points, 5)
    assert(#crossings == 2)
    assert(crossings[1] == 0)
    assert(crossings[2] == 5)

    crossings = mtscad.get_polygon_crossings(points, 2)
    assert(#crossings == 2)
    assert(crossings[1] == 0)
    assert(crossings[2] == 2)

    callback()
end)

mtt.register("is_point_in_polygon", function(callback)
    local points = {
        -- x, y (triangle)
        {0,0},
        {0,10},
        {10,0}
    }

    --assert(mtscad.is_point_in_polygon(points, 0, 0))
    assert(mtscad.is_point_in_polygon(points, 1, 5))
    assert(mtscad.is_point_in_polygon(points, 2, 5))
    assert(not mtscad.is_point_in_polygon(points, 6, 5))
    --assert(not mtscad.is_point_in_polygon(points, 7, 8))
    callback()
end)