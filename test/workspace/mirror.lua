local function fn(ctx)
    ctx
    :translate(2, 0, 1)
    :with("default:mese")
    :param2(3)
    :set_node()
end

return function(ctx)
    ctx
    :translate(5, 5, 5)
    :execute(fn)
    :mirror(1, 0, 0)
    :execute(fn)
end