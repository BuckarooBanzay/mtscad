
return function(callback)
    local t1 = { x=1 }
    local t2 = mtscad.merge(t1)
    assert(t2.x == 1)

    t1 = { x=1 }
    t2 = mtscad.merge(t1, { y=2 })
    assert(t2.x == 1)
    assert(t2.y == 2)

    t1 = { x=1 }
    t2 = mtscad.merge(t1, { y=2 }, { y=3 })
    assert(t2.x == 1)
    assert(t2.y == 3)

    t2 = mtscad.merge({ y=2 }, nil)
    assert(t2.y == 2)

    callback()
end