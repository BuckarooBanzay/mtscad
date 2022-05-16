
local another_lib = mtscad.load_module("another_lib/another_lib")

return function(ctx)
    ctx:execute(another_lib)
end