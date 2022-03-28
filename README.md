# mtscad

OpenSCAD inspired minetest mod

Status: **WIP**

# Example

Files placed in `<worlddir>/mtscad/`

stairs.lua
```lua
-- diagonal line along x and y with "count" nodes
local function diag_x_line(ctx, count)
    for x=0, count do
        ctx
        :translate(x, x, 0)
        :set_node()
    end
end

return function(ctx, opts)
    -- filler
    ctx
    :with(opts.filler)
    :execute(diag_x_line, opts.height-1)
    :translate(0, 0, opts.width-1)
    :execute(diag_x_line, opts.height-1)

    -- slopes above
    ctx
    :with(opts.slopes)
    :slope(-1, 1, 0)
    :translate(0, 1, 0)
    :execute(diag_x_line, opts.height-2)
    :translate(0, 0, opts.width-1)
    :execute(diag_x_line, opts.height-2)

    -- slopes below
    ctx
    :with(opts.slopes)
    :slope(1, -1, 0)
    :translate(1, 0, 0)
    :execute(diag_x_line, opts.height-2)
    :translate(0, 0, opts.width-1)
    :execute(diag_x_line, opts.height-2)

    -- stairs
    for z=1,opts.width-2 do
        ctx
        :with(opts.stairs)
        :slope(-1, 1, 0)
        :translate(0, 0, z)
        :execute(diag_x_line, opts.height-1)
    end
end
```

test.lua
```lua
local stairs = load("stairs")

return function(ctx)
    ctx
    :rotate(0, 0, 0)
    :execute(stairs, {
        height = 4,
        width = 5,
        slopes = "moreblocks:slope_stone",
        stairs = "moreblocks:stair_stone_alt_4",
        filler = "default:stone"
    })
end
```

```
/scad test
```