
return function(callback)
    -- matrix to pos and back
    local pos = { x=10, y=-10, z=20 }
    local m = mtscad.pos_to_matrix(pos)
    local pos2 = mtscad.matrix_to_pos(m)
    assert(vector.equals(pos, pos2), "pos-matrix-pos conversion")

    -- test clock-wise rotations

    -- rotate around x axis
    pos = {x=0, y=10, z=0}
    m = mtscad.multiply_matrix(mtscad.rotation_matrix_x(90), mtscad.pos_to_matrix(pos))
    pos2 = mtscad.matrix_to_pos(m)
    assert(vector.equals(pos2, {x=0,y=0,z=10}), "90° rotation around x axis")

    pos = {x=0, y=10, z=0}
    m = mtscad.multiply_matrix(mtscad.rotation_matrix_x(180), mtscad.pos_to_matrix(pos))
    pos2 = mtscad.matrix_to_pos(m)
    assert(vector.equals(pos2, {x=0,y=-10,z=0}), "180 rotation around x axis")

    pos = {x=0, y=10, z=0}
    m = mtscad.multiply_matrix(mtscad.rotation_matrix_x(270), mtscad.pos_to_matrix(pos))
    pos2 = mtscad.matrix_to_pos(m)
    assert(vector.equals(pos2, {x=0,y=0,z=-10}), "270 rotation around x axis")

    -- rotate around y axis
    pos = {x=10, y=0, z=0}
    m = mtscad.multiply_matrix(mtscad.rotation_matrix_y(90), mtscad.pos_to_matrix(pos))
    pos2 = mtscad.matrix_to_pos(m)
    assert(vector.equals(pos2, {x=0,y=0,z=-10}), "90° rotation around y axis")

    m = mtscad.multiply_matrix(mtscad.rotation_matrix_y(180), mtscad.pos_to_matrix(pos))
    pos2 = mtscad.matrix_to_pos(m)
    assert(vector.equals(pos2, {x=-10,y=0,z=0}), "180° rotation around y axis")

    m = mtscad.multiply_matrix(mtscad.rotation_matrix_y(270), mtscad.pos_to_matrix(pos))
    pos2 = mtscad.matrix_to_pos(m)
    assert(vector.equals(pos2, {x=0,y=0,z=10}), "270 rotation around y axis")

    -- rotate around z axis
    pos = {x=0, y=10, z=0}
    m = mtscad.multiply_matrix(mtscad.rotation_matrix_z(90), mtscad.pos_to_matrix(pos))
    pos2 = mtscad.matrix_to_pos(m)
    assert(vector.equals(pos2, {x=-10,y=0,z=0}), "90° rotation around z axis")

    pos = {x=0, y=10, z=0}
    m = mtscad.multiply_matrix(mtscad.rotation_matrix_z(180), mtscad.pos_to_matrix(pos))
    pos2 = mtscad.matrix_to_pos(m)
    assert(vector.equals(pos2, {x=0,y=-10,z=0}), "180° rotation around z axis")

    pos = {x=0, y=10, z=0}
    m = mtscad.multiply_matrix(mtscad.rotation_matrix_z(270), mtscad.pos_to_matrix(pos))
    pos2 = mtscad.matrix_to_pos(m)
    assert(vector.equals(pos2, {x=10,y=0,z=0}), "270 rotation around z axis")

    -- combined rotations

    -- rotate twice 180°
    pos = {x=0, y=10, z=0}
    m = mtscad.multiply_matrix(mtscad.rotation_matrix_z(180), mtscad.pos_to_matrix(pos))
    m = mtscad.multiply_matrix(mtscad.rotation_matrix_z(180), m)
    pos2 = mtscad.matrix_to_pos(m)
    assert(vector.equals(pos2, {x=0,y=10,z=0}), "2x 180° rotation around z axis")

    -- rotate 180° + 90° + 90°
    pos = {x=0, y=10, z=0}
    m = mtscad.multiply_matrix(mtscad.rotation_matrix_z(180), mtscad.pos_to_matrix(pos))
    m = mtscad.multiply_matrix(mtscad.rotation_matrix_z(90), m)
    m = mtscad.multiply_matrix(mtscad.rotation_matrix_z(90), m)
    pos2 = mtscad.matrix_to_pos(m)
    assert(vector.equals(pos2, {x=0,y=10,z=0}), "1x 180°, 2x 90° rotation around z axis")

    -- rotate x-90°, y-90°
    pos = {x=0, y=10, z=0}
    m = mtscad.multiply_matrix(mtscad.rotation_matrix_x(90), mtscad.pos_to_matrix(pos))
    m = mtscad.multiply_matrix(mtscad.rotation_matrix_y(90), m)
    pos2 = mtscad.matrix_to_pos(m)
    assert(vector.equals(pos2, {x=10,y=0,z=0}), "90°X + 90°Y rotation")

    callback()
end