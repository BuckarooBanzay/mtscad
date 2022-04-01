
function mtscad.Context:pattern(pattern)
    for yi=1,#pattern do
        local y = #pattern - yi
        for x=1,#pattern[yi] do
            local n = pattern[yi][x]

            self
            :with(n)
            :translate(x,y,0)
            :set_node()
        end
    end

    return self
end