require("mineunit")

mineunit("core")
sourcefile("init")

describe("mtscad.transform_pos() test", function()
	it("works with no rotation", function()
		local origin = { x=4, y=0, z=0 }
		local pos = { x=4, y=0, z=1 }
        local rotation = { x=0, y=0, z=0 }

        local tpos = mtscad.transform_pos(origin, pos, rotation)
        assert.equal(4, tpos.x)
        assert.equal(0, tpos.y)
        assert.equal(1, tpos.z)
	end)
	it("works with y=90 rotation", function()
		local origin = { x=4, y=0, z=0 }
		local pos = { x=5, y=0, z=0 }
        local rotation = { x=0, y=90, z=0 }

        local tpos = mtscad.transform_pos(origin, pos, rotation)
        assert.equal(4, tpos.x)
        assert.equal(0, tpos.y)
        assert.equal(-1, tpos.z)
	end)
end)
