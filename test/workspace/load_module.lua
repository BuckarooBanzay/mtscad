
local mylib = mtscad.load_module("lib/mylib")

return function(ctx)
    ctx:execute(mylib, 1, 2, 3)
end, {success=true}