function mtscad.Context:text(txt)
    local ctx = self:clone()
    for i=1,#txt do
        ctx = ctx
        :char(string.byte(txt, i))
        :translate(8, 0, 0)
    end
    return ctx
end

