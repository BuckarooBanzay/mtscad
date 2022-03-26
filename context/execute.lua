function mtscad.Context:execute(fn, ...)
    -- TODO: async
    fn(self, ...)
    return self
end