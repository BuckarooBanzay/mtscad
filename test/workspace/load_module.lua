
local mylib = mtscad.load_module("lib/mylib")

return function(ctx)
    ctx:execute(mylib)
end, {success=true}