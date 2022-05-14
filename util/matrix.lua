
-- https://en.wikipedia.org/wiki/Rotation_matrix#Basic%20rotations
function mtscad.rotation_matrix_x(angle)
    local rad = math.rad(angle)
    return {
        {1,0,0},
        {0,math.cos(rad),-math.sin(rad)},
        {0,math.sin(rad),math.cos(rad)}
    }
end

function mtscad.rotation_matrix_y(angle)
    local rad = math.rad(angle)
    return {
        {math.cos(rad),0,math.sin(rad)},
        {0,1,0},
        {-math.sin(rad),0,math.cos(rad)}
    }
end

function mtscad.rotation_matrix_z(angle)
    local rad = math.rad(angle)
    return {
        {math.cos(rad),-math.sin(rad),0},
        {math.sin(rad),math.cos(rad),0},
        {0,0,1}
    }
end

-- https://stackoverflow.com/questions/15022630/how-to-calculate-the-angle-from-rotation-matrix
function mtscad.matrix_angle_x(m)
    return math.floor(0.5+math.deg(math.atan2(m[3][2], m[3][3])))
end

function mtscad.matrix_angle_y(m)
    return math.floor(0.5+math.deg(math.atan2(-m[3][1], math.sqrt((m[3][2]^2) + (m[3][3]^2)))))
end

function mtscad.matrix_angle_z(m)
    return math.floor(0.5+math.deg(math.atan2(m[2][1], m[1][1])))
end

-- https://rosettacode.org/wiki/Matrix_multiplication#Lua
function mtscad.multiply_matrix(m1, m2)
	assert(#m1[1] == #m2, "inner matrix-dimensions must agree")
	local res = {}
	for i = 1, #m1 do
		res[i] = {}
		for j = 1, #m2[1] do
			res[i][j] = 0
			for k = 1, #m2 do
				res[i][j] = res[i][j] + m1[i][k] * m2[k][j]
			end
		end
	end
	return res
end

function mtscad.pos_to_matrix(pos)
    return {{pos.x},{pos.y},{pos.z}}
end

function mtscad.matrix_to_pos(m)
    return {
        x=math.floor(0.5+m[1][1]),
        y=math.floor(0.5+m[2][1]),
        z=math.floor(0.5+m[3][1])
    }
end