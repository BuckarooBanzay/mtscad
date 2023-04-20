
mtt.register("util_matrix", function(callback)
    -- matrix to pos and back
    local pos = { x=10, y=-10, z=20 }
    local m = mtscad.pos_to_matrix(pos)
    local pos2 = mtscad.matrix_to_pos(m)
    assert(vector.equals(pos, pos2), "pos-matrix-pos conversion")

    -- test clock-wise rotations

    -- rotate around x axis
    pos = {x=0, y=10, z=0}
    m = mtscad.rotation_matrix_x(0)
    m = mtscad.multiply_matrix(m, mtscad.rotation_matrix_x(90))
    pos2 = mtscad.matrix_to_pos(mtscad.multiply_matrix(m, mtscad.pos_to_matrix(pos)))
    assert(vector.equals(pos2, {x=0,y=0,z=10}), "90° rotation around x axis")

    m = mtscad.rotation_matrix_x(0)
    m = mtscad.multiply_matrix(m, mtscad.rotation_matrix_x(180))
    pos2 = mtscad.matrix_to_pos(mtscad.multiply_matrix(m, mtscad.pos_to_matrix(pos)))
    assert(vector.equals(pos2, {x=0,y=-10,z=0}), "180 rotation around x axis")

    m = mtscad.rotation_matrix_x(0)
    m = mtscad.multiply_matrix(m, mtscad.rotation_matrix_x(270))
    pos2 = mtscad.matrix_to_pos(mtscad.multiply_matrix(m, mtscad.pos_to_matrix(pos)))
    assert(vector.equals(pos2, {x=0,y=0,z=-10}), "270 rotation around x axis")

    -- rotate around y axis
    pos = {x=10, y=0, z=0}
    m = mtscad.rotation_matrix_x(0)
    m = mtscad.multiply_matrix(m, mtscad.rotation_matrix_y(90))
    pos2 = mtscad.matrix_to_pos(mtscad.multiply_matrix(m, mtscad.pos_to_matrix(pos)))
    assert(vector.equals(pos2, {x=0,y=0,z=-10}), "90° rotation around y axis")

    m = mtscad.rotation_matrix_x(0)
    m = mtscad.multiply_matrix(m, mtscad.rotation_matrix_y(180))
    pos2 = mtscad.matrix_to_pos(mtscad.multiply_matrix(m, mtscad.pos_to_matrix(pos)))
    assert(vector.equals(pos2, {x=-10,y=0,z=0}), "180° rotation around y axis")

    m = mtscad.rotation_matrix_x(0)
    m = mtscad.multiply_matrix(m, mtscad.rotation_matrix_y(270))
    pos2 = mtscad.matrix_to_pos(mtscad.multiply_matrix(m, mtscad.pos_to_matrix(pos)))
    assert(vector.equals(pos2, {x=0,y=0,z=10}), "270 rotation around y axis")

    -- rotate around z axis
    pos = {x=0, y=10, z=0}
    m = mtscad.rotation_matrix_x(0)
    m = mtscad.multiply_matrix(m, mtscad.rotation_matrix_z(90))
    pos2 = mtscad.matrix_to_pos(mtscad.multiply_matrix(m, mtscad.pos_to_matrix(pos)))
    assert(vector.equals(pos2, {x=-10,y=0,z=0}), "90° rotation around z axis")

    m = mtscad.rotation_matrix_x(0)
    m = mtscad.multiply_matrix(m, mtscad.rotation_matrix_z(180))
    pos2 = mtscad.matrix_to_pos(mtscad.multiply_matrix(m, mtscad.pos_to_matrix(pos)))
    assert(vector.equals(pos2, {x=0,y=-10,z=0}), "180° rotation around z axis")

    m = mtscad.rotation_matrix_x(0)
    m = mtscad.multiply_matrix(m, mtscad.rotation_matrix_z(270))
    pos2 = mtscad.matrix_to_pos(mtscad.multiply_matrix(m, mtscad.pos_to_matrix(pos)))
    assert(vector.equals(pos2, {x=10,y=0,z=0}), "270 rotation around z axis")

    -- combined rotations

    -- rotate twice 180°
    pos = {x=0, y=10, z=0}
    m = mtscad.rotation_matrix_x(0)
    m = mtscad.multiply_matrix(m, mtscad.rotation_matrix_z(180))
    m = mtscad.multiply_matrix(m, mtscad.rotation_matrix_z(180))
    pos2 = mtscad.matrix_to_pos(mtscad.multiply_matrix(m, mtscad.pos_to_matrix(pos)))
    assert(vector.equals(pos2, {x=0,y=10,z=0}), "2x 180° rotation around z axis")

    -- rotate 180° + 90° + 90°
    pos = {x=0, y=10, z=0}
    m = mtscad.rotation_matrix_x(0)
    m = mtscad.multiply_matrix(m, mtscad.rotation_matrix_z(180))
    m = mtscad.multiply_matrix(m, mtscad.rotation_matrix_z(90))
    m = mtscad.multiply_matrix(m, mtscad.rotation_matrix_z(90))
    pos2 = mtscad.matrix_to_pos(mtscad.multiply_matrix(m, mtscad.pos_to_matrix(pos)))
    assert(vector.equals(pos2, {x=0,y=10,z=0}), "1x 180°, 2x 90° rotation around z axis")

    -- rotate x 90°, y 90°
    pos = {x=0, y=10, z=0}
    m = mtscad.rotation_matrix_x(0)
    m = mtscad.multiply_matrix(m, mtscad.rotation_matrix_x(90), mtscad.pos_to_matrix(pos))
    m = mtscad.multiply_matrix(m, mtscad.rotation_matrix_y(90), m)
    pos2 = mtscad.matrix_to_pos(mtscad.multiply_matrix(m, mtscad.pos_to_matrix(pos)))
    assert(vector.equals(pos2, {x=0,y=0,z=10}), "90°X + 90°Y rotation")

    -- rotate x 90°, y 180°
    pos = {x=0, y=10, z=0}
    m = mtscad.rotation_matrix_x(0)
    m = mtscad.multiply_matrix(m, mtscad.rotation_matrix_x(90), mtscad.pos_to_matrix(pos))
    m = mtscad.multiply_matrix(m, mtscad.rotation_matrix_y(180), m)
    local angles = mtscad.get_matrix_angles(m)
    assert(angles.x == 90, "90° x angle")
    assert(angles.y == 0, "0° y angle")
    assert(angles.z == 180, "180° z angle")
    pos2 = mtscad.matrix_to_pos(mtscad.multiply_matrix(m, mtscad.pos_to_matrix(pos)))
    assert(vector.equals(pos2, {x=0,y=0,z=10}), "90°X + 180°Y rotation")

    -- rotate x 90°, y -90°
    pos = {x=0, y=10, z=0}
    m = mtscad.rotation_matrix_x(0)
    m = mtscad.multiply_matrix(m, mtscad.rotation_matrix_x(90), mtscad.pos_to_matrix(pos))
    m = mtscad.multiply_matrix(m, mtscad.rotation_matrix_z(90), m)
    angles = mtscad.get_matrix_angles(m)
    assert(angles.x == 180, "x angle")
    assert(angles.y == -90, "y angle")
    assert(angles.z == -90, "z angle")
    pos2 = mtscad.matrix_to_pos(mtscad.multiply_matrix(m, mtscad.pos_to_matrix(pos)))
    assert(vector.equals(pos2, {x=-10,y=0,z=0}), "90°X + -90°Y rotation")

    callback()
end)