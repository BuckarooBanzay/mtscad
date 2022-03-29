function mtscad.Context:cube(x, y, z)
    for xi=1,x do
        for yi=1,y do
            for zi=1,z do
                self
                :translate(xi-1, yi-1, zi-1)
                :set_node()
            end
        end
    end
    return self
end

