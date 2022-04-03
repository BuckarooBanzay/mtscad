local pos1, pos2 = ...

return function(callback)
    minetest.emerge_area(pos1, pos2, function(_, _, calls_remaining)
      if calls_remaining == 0 then
        callback()
      end
    end)
  end