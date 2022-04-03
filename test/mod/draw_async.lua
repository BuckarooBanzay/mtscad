return function(origin, callback)
    local ctx = mtscad.create_context({ pos = origin })
    ctx.job_context.register_on_done(function(_, err_msg)
      if err_msg then
        error(err_msg)
      end
      assert(minetest.get_node(vector.add(origin, {x=0,y=0,z=0})).name == "default:mese")
      assert(minetest.get_node(vector.add(origin, {x=1,y=0,z=0})).name == "default:mese")
      assert(minetest.get_node(vector.add(origin, {x=2,y=0,z=0})).name == "default:mese")
      callback()
    end)

    -- workspace begins here --
    local fn1 = function(c) c:translate(0,0,0):set_node() end
    local fn2 = function(c) c:translate(1,0,0):set_node() end
    local fn3 = function(c) c:translate(2,0,0):set_node() end

    ctx
    :with("default:mese")
    :execute(fn1)
    :execute(fn2)
    :execute(fn3)
    -- workspace ends here --

    -- process async jobs
    ctx.job_context.process()
  end