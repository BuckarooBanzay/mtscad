local function add_rotation(a, b)
    -- TODO: only 90°-increments allowed
    a = a or 0
    b = b or 0
    local sum = a + b
    while sum >= 360 do
        sum = sum - 360
    end
    return sum
end

function mtscad.Context:rotate(x, y, z)
    local ctx = self:clone()
    ctx.rotation.x = add_rotation(ctx.rotation.x, x)
    ctx.rotation.y = add_rotation(ctx.rotation.y, y)
    ctx.rotation.z = add_rotation(ctx.rotation.z, z)
    return ctx
end

