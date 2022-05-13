
return function(callback)
    -- y axis
    assert(mtscad.rotate_facedir(1, "y+", 0) == 3) -- 90° ccw
    assert(mtscad.rotate_facedir(2, "y+", 0) == 2) -- 180° ccw
    assert(mtscad.rotate_facedir(3, "y+", 0) == 1) -- 270° ccw
    assert(mtscad.rotate_facedir(4, "y+", 0) == 0) -- 360° ccw

    -- x axis
    assert(mtscad.rotate_facedir(1, "x+", 0) == 8) -- 90° ccw
    assert(mtscad.rotate_facedir(2, "x+", 0) == 22) -- 180° ccw
    assert(mtscad.rotate_facedir(3, "x+", 0) == 4) -- 270° ccw
    assert(mtscad.rotate_facedir(4, "x+", 0) == 0) -- 360° ccw

    -- z axis
    assert(mtscad.rotate_facedir(1, "z+", 0) == 12) -- 90° ccw
    assert(mtscad.rotate_facedir(2, "z+", 0) == 20) -- 180° ccw
    assert(mtscad.rotate_facedir(3, "z+", 0) == 16) -- 270° ccw
    assert(mtscad.rotate_facedir(4, "z+", 0) == 0) -- 360° ccw

    callback()
end