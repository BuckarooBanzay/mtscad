-- simple smoke tests
if minetest.settings:get_bool("enable_integration_test") then
  minetest.log("warning", "[TEST] integration-test enabled!")
  minetest.register_on_mods_loaded(function()
      -- just exit gracefully
      minetest.request_shutdown("success")
  end)
end