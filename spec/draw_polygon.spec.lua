local origin = ...

mtt.register("draw_polygon", function(callback)
  local ctx = mtscad.create_context({ pos = origin })
  ctx.job_context.register_on_done(function(_, err_msg)
    if err_msg then
      error(err_msg)
    end
    assert(minetest.get_node(vector.add(origin, {x=0,y=0,z=0})).name == "default:cobble")
    assert(minetest.get_node(vector.add(origin, {x=10,y=0,z=0})).name == "default:cobble")
    assert(minetest.get_node(vector.add(origin, {x=0,y=10,z=0})).name == "default:cobble")
    assert(minetest.get_node(vector.add(origin, {x=2,y=2,z=0})).name == "air")
    callback()
  end)

  local mod = mtscad.load_module("draw_polygon")
  mod(ctx)

  -- process async jobs
  ctx.job_context.process()
end)

mtt.register("draw_polygon_fill", function(callback)
    origin = vector.add(origin, {x=0, y=0, z=0})
    local ctx = mtscad.create_context({ pos = origin })
    ctx.job_context.register_on_done(function(_, err_msg)
      if err_msg then
        error(err_msg)
      end
      assert(minetest.get_node(vector.add(origin, {x=0,y=0,z=0})).name == "default:cobble")
      assert(minetest.get_node(vector.add(origin, {x=10,y=0,z=0})).name == "default:cobble")
      assert(minetest.get_node(vector.add(origin, {x=0,y=10,z=0})).name == "default:cobble")
      assert(minetest.get_node(vector.add(origin, {x=2,y=2,z=0})).name == "default:cobble")
      callback()
    end)

    local mod = mtscad.load_module("draw_polygon_fill")
    mod(ctx)

    -- process async jobs
    ctx.job_context.process()
  end)