

local slope_param2 = {
    ["1,1,0"] = 3,
    ["-1,0,-1"] = 9,
    ["-1,0,1"] = 5,
    ["1,0,-1"] = 11,
    ["1,0,1"] = 14,
    ["1,-1,0"] = 21,
    ["0,1,1"] = 2,
    ["0,-1,1"] = 22,
    ["-1,1,0"] = 1,
    ["-1,-1,0"] = 23,
    ["0,1,-1"] = 0,
    ["0,-1,-1"] = 20
}

function mtscad.Context:slope(x, y, z)
    local ctx = self:clone()
    ctx.node.param2 = slope_param2[x .. "," .. y .. "," .. z]
    return ctx
end

