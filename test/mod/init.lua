local pos1 = vector.new(0,0,0)
local pos2 = vector.new(30,30,30)

local MP = minetest.get_modpath("mtscad_test")
local draw_line = loadfile(MP .. "/draw_line.lua")()
local draw_async = loadfile(MP .. "/draw_async.lua")()
local prepare_world = loadfile(MP .. "/prepare_world.lua")(pos1, pos2)

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