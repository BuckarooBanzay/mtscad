local pos1 = vector.new(0,0,0)
local pos2 = vector.new(30,30,30)

local function prepare_world(callback)
  minetest.emerge_area(pos1, pos2, function(_, _, calls_remaining)
    if calls_remaining == 0 then
      callback()
    end
  end)
end

local function draw(callback)

  local ctx = mtscad.create_context({ pos = pos1 })
  ctx.job_context.register_on_done(function(_, err_msg)
    if err_msg then
      error(err_msg)
    end
    assert(minetest.get_node({x=10,y=10,z=10}).name == "default:mese")
    callback()
  end)

  -- workspace begins here --
  ctx
  :with("default:mese")
  :line(10,10,10)
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
        draw(function()
          -- exit gracefully
          minetest.request_shutdown("success")
        end)
      end)
    end)
  end)
end