require("mineunit")

mineunit("core")
sourcefile("init")

describe("mtscad.rotate_facedir() test", function()
	it("various rotation tests", function()
        -- y axis
		assert.equal(3, mtscad.rotate_facedir(1, "y+", 0)) -- 90° ccw
        assert.equal(2, mtscad.rotate_facedir(2, "y+", 0)) -- 180° ccw
        assert.equal(1, mtscad.rotate_facedir(3, "y+", 0)) -- 270° ccw
        assert.equal(0, mtscad.rotate_facedir(4, "y+", 0)) -- 360° ccw

        -- x axis
        assert.equal(8, mtscad.rotate_facedir(1, "x+", 0)) -- 90° ccw
        assert.equal(22, mtscad.rotate_facedir(2, "x+", 0)) -- 180° ccw
        assert.equal(4, mtscad.rotate_facedir(3, "x+", 0)) -- 270° ccw
        assert.equal(0, mtscad.rotate_facedir(4, "x+", 0)) -- 360° ccw

        -- z axis
        assert.equal(12, mtscad.rotate_facedir(1, "z+", 0)) -- 90° ccw
        assert.equal(20, mtscad.rotate_facedir(2, "z+", 0)) -- 180° ccw
        assert.equal(16, mtscad.rotate_facedir(3, "z+", 0)) -- 270° ccw
        assert.equal(0, mtscad.rotate_facedir(4, "z+", 0)) -- 360° ccw
    end)
end)
