function mtscad.Context:sphere(radius, hollow)
    local min_radius, max_radius = radius * (radius - 1), radius * (radius + 1)
	for z = -radius, radius do
		for y = -radius, radius do
			for x = -radius, radius do
				local squared = x * x + y * y + z * z
				if squared <= max_radius and (not hollow or squared >= min_radius) then
                    self
                    :translate(x, y, z)
                    :set_node()
				end
			end
		end
	end
end