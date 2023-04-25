
function mtscad.Context:with(node_spec)
    local ctx = self:clone()
    ctx.node_spec = node_spec
    return ctx
end

