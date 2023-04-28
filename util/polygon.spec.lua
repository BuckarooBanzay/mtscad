
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
    assert(crossings[2] == 8)

    callback()
end)

mtt.register("get_polygon_crossings_2", function(callback)
    local points = {
        -- x, y (octagon)
        {0, 5},
        {0, 10},
        {5, 15},
        {10, 15},
        {15, 10},
        {15, 5},
        {10, 0},
        {5, 0},
        {0, 5}
    }

    local crossings = mtscad.get_polygon_crossings(points, 7)
    assert(#crossings == 2)
    assert(crossings[1] == 0)
    assert(crossings[2] == 15)

    crossings = mtscad.get_polygon_crossings(points, 1)
    assert(#crossings == 2)
    assert(crossings[1] == 4)
    assert(crossings[2] == 11)

    callback()
end)

mtt.register("is_point_in_polygon", function(callback)
    local points = {
        -- x, y (triangle)
        {0,0},
        {0,10},
        {10,0}
    }

    assert(mtscad.is_point_in_polygon(points, 1, 1))
    assert(mtscad.is_point_in_polygon(points, 1, 5))
    assert(mtscad.is_point_in_polygon(points, 2, 5))
    assert(not mtscad.is_point_in_polygon(points, 9, 9))
    assert(not mtscad.is_point_in_polygon(points, 8, 9))
    assert(not mtscad.is_point_in_polygon(points, 7, 9))
    assert(not mtscad.is_point_in_polygon(points, 6, 9))
    assert(not mtscad.is_point_in_polygon(points, 8, 8))
    assert(not mtscad.is_point_in_polygon(points, 18, 18))
    callback()
end)