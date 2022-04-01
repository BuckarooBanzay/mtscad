
-- https://github.com/minetest/minetest/pull/11932 / https://github.com/aerkiaga
-- Map each facedir to the result of applying
-- right-hand rotation around y+ or z+ vector
local rotated_facedir_map = {
	["y+"] = {
		[0] = 3, 0, 1, 2,
		19, 16, 17, 18,
		15, 12, 13, 14,
		7, 4, 5, 6,
		11, 8, 9, 10,
		21, 22, 23, 20
	},
	["z+"] = {
		[0] = 12, 13, 14, 15,
		7, 4, 5, 6,
		9, 10, 11, 8,
		20, 21, 22, 23,
		0, 1, 2, 3,
		16, 17, 18, 19,
	},
}

-- Map rotations on all 6 orthogonal vectors to
-- rotations around just y+ and z+
local vector_lambda_map = {
	["x+"] = function (f, r, x)
		return f(3, "y+", f(r, "z+", f(1, "y+", x))) end,
	["x-"] = function (f, r, x)
		return f(1, "y+", f(r, "z+", f(3, "y+", x))) end,
	["y+"] = function (f, r, x)
		return f(r, "y+", x) end,
	["y-"] = function (f, r, x)
		return f(4 - r, "y+", x) end,
	["z+"] = function (f, r, x)
		return f(r, "z+", x) end,
	["z-"] = function (f, r, x)
		return f(4 - r, "z+", x) end,
}

function mtscad.rotate_facedir(rotation, vector_name, facedir)
	facedir = facedir or 0
	local function lookup_function(r, n, x)
		if r == 0 then return x end
		return lookup_function(r - 1, n, rotated_facedir_map[n][x])
	end
	local translation_function = vector_lambda_map[vector_name]
		or function () return nil end
	return translation_function(lookup_function, rotation % 4, facedir)
end
