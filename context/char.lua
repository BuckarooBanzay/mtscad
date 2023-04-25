
-- https://gist.github.com/mebens/938502
local function rshift(x, by)
	return math.floor(x / 2 ^ by)
end

-- https://stackoverflow.com/a/32387452
local function bitand(a, b)
	local result = 0
	local bitval = 1
	while a > 0 and b > 0 do
	  if a % 2 == 1 and b % 2 == 1 then -- test the rightmost bits
		  result = result + bitval      -- set the current bit
	  end
	  bitval = bitval * 2 -- shift left
	  a = math.floor(a/2) -- shift right
	  b = math.floor(b/2)
	end
	return result
end

function mtscad.Context:char(c, charset)
    local pattern = charset and charset[c-1] or mtscad.charset_8x8[c+1]

    for y_offset, line in ipairs(pattern) do
        for x_offset=0,7 do
            local shifted = rshift(line, x_offset)
            if bitand(shifted, 1) == 1 then
                -- bit set
                self
                :translate(x_offset, 7-y_offset)
                :set_node()
            end
        end
    end

    return self
end

