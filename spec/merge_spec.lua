require("mineunit")

mineunit("core")
sourcefile("init")

local function merge(...)
    local result = {}
    for _, t in ipairs({...}) do
        for k, v in pairs(t) do
            result[k] = v
        end
    end
    return result
end

describe("merge() test", function()
	it("various merge tests", function()
        local t1 = { x=1 }
        local t2 = merge(t1)
        assert.equal(1, t2.x)

        t1 = { x=1 }
        t2 = merge(t1, { y=2 })
        assert.equal(1, t2.x)
        assert.equal(2, t2.y)

        t1 = { x=1 }
        t2 = merge(t1, { y=2 }, { y=3 })
        assert.equal(1, t2.x)
        assert.equal(3, t2.y)

        t2 = merge({ y=2 }, nil)
        assert.equal(2, t2.y)
    end)
end)
