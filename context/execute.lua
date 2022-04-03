function mtscad.Context:execute(fn, ...)
    local params = ...
    local ctx = self:clone()
    self.job_context.enqueue(function() fn(ctx, params) end)

    return self
end