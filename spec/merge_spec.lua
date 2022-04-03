require("mineunit")

mineunit("core")
sourcefile("init")

describe("merge() test", function()
	it("various merge tests", function()
        local t1 = { x=1 }
        local t2 = mtscad.merge(t1)
        assert.equal(1, t2.x)

        t1 = { x=1 }
        t2 = mtscad.merge(t1, { y=2 })
        assert.equal(1, t2.x)
        assert.equal(2, t2.y)

        t1 = { x=1 }
        t2 = mtscad.merge(t1, { y=2 }, { y=3 })
        assert.equal(1, t2.x)
        assert.equal(3, t2.y)

        t2 = mtscad.merge({ y=2 }, nil)
        assert.equal(2, t2.y)
    end)
end)
