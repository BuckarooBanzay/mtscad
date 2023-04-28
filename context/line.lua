
local function round(n)
    return math.floor(n+0.5)
end

function mtscad.Context:line(x, y, z)
    local steps = math.abs(x)
    steps = math.max(steps, math.abs(y))
    steps = math.max(steps, math.abs(z))

    for step=0,steps do
        local xi = round(x / steps * step)
        local yi = round(y / steps * step)
        local zi = round(z / steps * step)
        self
        :translate(xi,yi,zi)
        :set_node()
    end
    return self
end