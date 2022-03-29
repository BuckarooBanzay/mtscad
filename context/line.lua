
function mtscad.Context:line(x, y, z)
    local steps = math.sqrt( (x*x) + (y*y) + (z*z) )
    for step=0,steps do
        local xi = math.ceil(x / steps * step)
        local yi = math.ceil(y / steps * step)
        local zi = math.ceil(z / steps * step)
        self
        :translate(xi,yi,zi)
        :set_node()
    end
    return self
end