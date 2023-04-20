
mtt.register("util_extents", function(callback)
    local min = {x=0, y=0, z=0}
    local max = {x=10, y=10, z=10}

    mtscad.extents(min, max, {x=20, y=0, z=0})
    assert(max.x == 20)
    assert(max.y == 10)
    assert(max.z == 10)

    callback()
end)