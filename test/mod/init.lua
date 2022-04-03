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
  ctx
  :with("default:stone")
  :line(10,10,10)

  callback()
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