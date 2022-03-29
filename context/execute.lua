function mtscad.Context:execute(fn, ...)

    self.job_context.count = self.job_context.count + 1
    minetest.after(0.1, function(...)
        fn(self:clone(), ...)
        self.job_context.count = self.job_context.count - 1
        if self.job_context.count == 0 then
            self.job_context.done_callback()
        end
    end, ...)

    return self
end