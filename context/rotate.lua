
function mtscad.Context:rotate(x, y, z)
    local ctx = self:clone()
    ctx.rotation = mtscad.multiply_matrix(mtscad.rotation_matrix_x(x), ctx.rotation)
    ctx.rotation = mtscad.multiply_matrix(mtscad.rotation_matrix_y(y), ctx.rotation)
    ctx.rotation = mtscad.multiply_matrix(mtscad.rotation_matrix_z(z), ctx.rotation)
    return ctx
end

