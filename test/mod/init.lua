local pos1 = vector.new(0,0,0)
local pos2 = vector.new(30,30,30)

local function prepare_world(callback)
  minetest.emerge_area(pos1, pos2, function(_, _, calls_remaining)
    if calls_remaining == 0 then
      callback()
    end
  end)
end

local function draw_line(origin, callback)
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

local function draw_async(origin, callback)
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

-- simple smoke tests
if minetest.settings:get_bool("enable_integration_test") then
  minetest.log("warning", "[TEST] integration-test enabled!")
  minetest.register_on_mods_loaded(function()
    -- defer emerging until stuff is settled
    minetest.after(1, function()
      prepare_world(function()
        draw_line({x=0, y=0, z=0}, function()
          draw_async({x=20, y=0, z=0}, function()
            -- exit gracefully
            minetest.request_shutdown("success")
          end)
        end)
      end)
    end)
  end)
end