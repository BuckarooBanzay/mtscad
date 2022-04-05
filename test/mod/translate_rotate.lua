local origin = ...

return function(callback)
  print("translate_rotate")

  local ctx = mtscad.create_context({ pos = origin })
  ctx.job_context.register_on_done(function(_, err_msg)
    if err_msg then
      error(err_msg)
    end
    assert(minetest.get_node(vector.add(origin, {x=0,y=0,z=0})).name == "default:mese")
    assert(minetest.get_node(vector.add(origin, {x=0,y=0,z=-1})).name == "wool:white")
    callback()
  end)

  local mod = mtscad.load_module("translate_rotate")
  mod(ctx)

  -- process async jobs
  ctx.job_context.process()
end