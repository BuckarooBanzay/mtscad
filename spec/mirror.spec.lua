local origin = ...

mtt.register("mirror", function(callback)
  local ctx = mtscad.create_context({ pos = origin })
  ctx.job_context.register_on_done(function(_, err_msg)
    if err_msg then
      error(err_msg)
    end
    assert(minetest.get_node(vector.add(origin, {x=5+2,y=5,z=5+1})).name == "default:mese")
    assert(minetest.get_node(vector.add(origin, {x=5+2,y=5,z=5+1})).param2 == 3)
    assert(minetest.get_node(vector.add(origin, {x=5-2,y=5,z=5+1})).name == "default:mese")
    assert(minetest.get_node(vector.add(origin, {x=5-2,y=5,z=5+1})).param2 == 1)
    callback()
  end)

  local mod = mtscad.load_module("mirror")
  mod(ctx)

  -- process async jobs
  ctx.job_context.process()
end)