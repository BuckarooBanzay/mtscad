# mtscad

OpenSCAD inspired minetest mod

Status: **WIP**

![](https://github.com/BuckarooBanzay/mtscad/workflows/luacheck/badge.svg)
![](https://github.com/BuckarooBanzay/mtscad/workflows/test/badge.svg)
[![License](https://img.shields.io/badge/License-MIT%20and%20CC%20BY--SA%203.0-green.svg)](license.txt)
[![Download](https://img.shields.io/badge/Download-ContentDB-blue.svg)](https://content.minetest.net/packages/BuckarooBanzay/mtscad)

Required engine-version: `5.5.0`

# Example

Files placed in `<worlddir>/mtscad/`

stairs.lua
```lua
return function(ctx, opts)
    opts = merge_table({
        height = 4,
        width = 5,
        slopes = "moreblocks:slope_stone",
        stairs = "moreblocks:stair_stone_alt_4",
        filler = "default:stone"
    }, opts)

    -- filler
    ctx
    :with(opts.filler)
    :line(opts.height-1, opts.height-1, 0)
    :translate(0, 0, opts.width-1)
    :line(opts.height-1, opts.height-1, 0)

    -- slopes above
    ctx
    :with(opts.slopes)
    :slope(-1, 1, 0)
    :translate(0, 1, 0)
    :line(opts.height-2, opts.height-2, 0)
    :translate(0, 0, opts.width-1)
    :line(opts.height-2, opts.height-2, 0)

    -- slopes below
    ctx
    :with(opts.slopes)
    :slope(1, -1, 0)
    :translate(1, 0, 0)
    :line(opts.height-2, opts.height-2, 0)
    :translate(0, 0, opts.width-1)
    :line(opts.height-2, opts.height-2, 0)

    -- stairs
    for z=1,opts.width-2 do
        ctx
        :with(opts.stairs)
        :slope(-1, 1, 0)
        :translate(0, 0, z)
        :line(opts.height-1, opts.height-1, 0)
    end
end
```

test.lua
```lua
-- load function from module
local stairs = load("stairs")

return function(ctx)
    ctx
    :translate(0, 0, 0) -- apply translations here
    :rotate(0, 0, 0) -- apply rotations here
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