function mtscad.Context:execute(fn, ...)
    fn(self, ...)
    return self
end