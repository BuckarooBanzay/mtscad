
local function apply_axis(ctx, axis, v)
    assert(v <= 1)
    if v == 1 then
        -- invert axis
        ctx.pos_factor[axis] = ctx.pos_factor[axis] * -1
    end
end

function mtscad.Context:mirror(x, y, z)
    local ctx = self:clone()
    apply_axis(ctx, "x", x)
    apply_axis(ctx, "y", y)
    apply_axis(ctx, "z", z)
    return ctx
end