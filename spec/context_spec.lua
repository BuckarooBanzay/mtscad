require("mineunit")

mineunit("core")

sourcefile("init")

-- patch test env
function vector.zero()
	return vector.new(0, 0, 0)
end

function vector.copy(v)
	return vector.new(v.x, v.y, v.z)
end

describe("mtscad.create_context() test", function()
	it("set_node() works", function()
		local origin = { x=4, y=0, z=0 }
        local ctx = mtscad.create_context({ pos = origin })

        ctx
        :with("default:mese")
        :set_node()

        local node = minetest.get_node(origin)
        assert.not_nil(node)
        assert.equal("default:mese", node.name)
	end)
end)
