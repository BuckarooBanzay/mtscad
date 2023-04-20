
local another_lib = mtscad.load_module("another_lib/another_lib")

return function(ctx, a, b, c)
    assert(a == 1)
    assert(b == 2)
    assert(c == 3)
    ctx:execute(another_lib)
end