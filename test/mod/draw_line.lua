local origin = ...

mtt.register("draw_line", function(callback)
  local ctx = mtscad.create_context({ pos = origin })
  ctx.job_context.register_on_done(function(_, err_msg)
    if err_msg then
      error(err_msg)
    end
    assert(minetest.get_node(vector.add(origin, {x=0,y=0,z=0})).name == "default:mese")
    assert(minetest.get_node(vector.add(origin, {x=10,y=10,z=10})).param2 == 3)
    callback()
  end)

  local mod = mtscad.load_module("draw_line")
  mod(ctx)

  -- process async jobs
  ctx.job_context.process()
end)