
return function(origin, callback)
    local ctx = mtscad.create_context({ pos = origin })
    ctx.job_context.register_on_done(function(_, err_msg)
      if err_msg then
        error(err_msg)
      end
      assert(minetest.get_node(vector.add(origin, {x=0,y=0,z=0})).name == "default:mese")
      assert(minetest.get_node(vector.add(origin, {x=10,y=10,z=10})).param2 == 3)
      callback()
    end)

    -- workspace begins here --
    ctx
    :with("default:mese")
    :slope(1,1,0)
    :line(10,10,10)
    -- workspace ends here --

    -- process async jobs
    ctx.job_context.process()
  end