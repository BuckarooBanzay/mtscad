function mtscad.Context:cylinder(radius, height, fill)
	radius = math.floor(radius + 0.5)
	local min_radius, max_radius = radius * (radius - 1), radius * (radius + 1)
	for z = -radius, radius do
		for y = 0, height-1 do
			for x = -radius, radius do
				local squared = x * x + z * z
				if squared <= max_radius and (fill or squared >= min_radius) then
					self
					:translate(x, y, z)
					:set_node()
				end
			end
		end
	end
end