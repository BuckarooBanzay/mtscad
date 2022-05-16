local pos1 = vector.new(0,0,0)
local pos2 = vector.new(30,30,30)

local jobs = {}

local MP = minetest.get_modpath("mtscad_test")
table.insert(jobs, loadfile(MP .. "/util_merge.lua")())
table.insert(jobs, loadfile(MP .. "/util_rotate_facedir.lua")())
table.insert(jobs, loadfile(MP .. "/util_matrix.lua")())
table.insert(jobs, loadfile(MP .. "/prepare_world.lua")(pos1, pos2))
table.insert(jobs, loadfile(MP .. "/load_module.lua")({x=0, y=0, z=20}))
table.insert(jobs, loadfile(MP .. "/draw_line.lua")({x=0, y=0, z=0}))
table.insert(jobs, loadfile(MP .. "/draw_async.lua")({x=20, y=0, z=0}))
table.insert(jobs, loadfile(MP .. "/translate_rotate.lua")({x=20, y=0, z=20}))

local job_index = 1

local function worker()
  local job = jobs[job_index]
  if not job then
    -- exit gracefully
    minetest.request_shutdown("success")
    return
  end

  job(function()
    job_index = job_index + 1
    minetest.after(0, worker)
  end)
end

minetest.log("warning", "[TEST] integration-test enabled!")
minetest.register_on_mods_loaded(function()
  -- defer emerging until stuff is settled
  minetest.after(1, worker)
end)
