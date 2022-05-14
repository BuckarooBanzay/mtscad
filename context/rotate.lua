
function mtscad.Context:rotate(x, y, z)
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

