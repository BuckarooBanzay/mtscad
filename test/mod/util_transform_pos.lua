
return function(callback)
    local origin = { x=4, y=0, z=0 }
    local pos = { x=4, y=0, z=1 }
    local rotation = { x=0, y=0, z=0 }

    local tpos = mtscad.transform_pos(origin, pos, rotation)
    assert(tpos.x == 4)
    assert(tpos.y == 0)
    assert(tpos.z == 1)

    origin = { x=4, y=0, z=0 }
    pos = { x=5, y=0, z=0 }
    rotation = { x=0, y=90, z=0 }

    tpos = mtscad.transform_pos(origin, pos, rotation)
    assert(tpos.x == 4)
    assert(tpos.y == 0)
    assert(tpos.z == -1)

    callback()
end