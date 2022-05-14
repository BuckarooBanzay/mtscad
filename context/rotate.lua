
function mtscad.Context:rotate(x, y, z)
    assert(x % 90 == 0, "x angle is a multiple of 90°")
    assert(y % 90 == 0, "y angle is a multiple of 90°")
    assert(z % 90 == 0, "z angle is a multiple of 90°")
    local ctx = self:clone()
    if x ~= 0 then
        ctx.rotation = mtscad.multiply_matrix(ctx.rotation, mtscad.rotation_matrix_x(x))
    end
    if y ~= 0 then
        ctx.rotation = mtscad.multiply_matrix(ctx.rotation, mtscad.rotation_matrix_y(y))
    end
    if z ~= 0 then
        ctx.rotation = mtscad.multiply_matrix(ctx.rotation, mtscad.rotation_matrix_z(z))
    end
    return ctx
end

