# mtscad

> Or: How I Learned to Stop Worrying and Love `minetest.set_node()`

OpenSCAD inspired minetest mod

Status: **WIP**

![](https://github.com/BuckarooBanzay/mtscad/workflows/luacheck/badge.svg)
![](https://github.com/BuckarooBanzay/mtscad/workflows/test/badge.svg)
[![License](https://img.shields.io/badge/License-MIT%20and%20CC%20BY--SA%203.0-green.svg)](license.txt)
[![Download](https://img.shields.io/badge/Download-ContentDB-blue.svg)](https://content.minetest.net/packages/BuckarooBanzay/mtscad)

Required engine-version: `5.3.0`

# Example

## Simple cube

`${worldpath}/mtscad/example.lua`
```lua
return function(ctx)
    ctx
    :with({ name="default:cobble" }) -- material to use
    :translate(1, 2, 3) -- move context
    :cube(5,5,5) -- draw cube with 5 nodes sidelength
end
```

Execute with:
* `/scad_origin`
* `/scad example`

## Composition

functions can be composed and reused

```lua
local function mycube(ctx)
    ctx:cube(5,5,5)
    -- TODO other magic for my-cube
end

return function(ctx)
    ctx
    :with({ name="default:cobble" }) -- material to use
    :translate(1, 2, 3) -- move context
    :execute(mycube) -- execute mycube function
    :translate(10, 0, 0) -- move context again by 10 nodes to x+
    :execute(mycube) -- execute mycube function on the new position
end
```

**NOTE:**: the `ctx:execute(fn, opts...)` function executes the passed function asynchronously

## Modules

TODO

# Api

## `ctx:with(node_spec)`

Specify which nodes to use:
```lua
-- simple node
ctx:with("default:cobble")

-- node-table
ctx:with({ name="default:cobble" })

-- node-table with param2
ctx:with({ name="default:cobble", param2=1 })

-- producer-function
ctx:with(function()
    return { name="default:stone", param2=math.random(10) }
end)
```

## `ctx:set_node()`

## `ctx:execute(fn, opts...)`

## `ctx:translate(x,y,z)`

## `ctx:rotate(x,y,z)`

## `ctx:mirror(x,y,z)`

## `ctx:line(x,y,z)`

## `ctx:cube(x,y,z)`

## `ctx:sphere(radius, fill?)`

## `ctx:dome(radius, fill?)`

## `ctx:cylinder(radius, height, fill?)`

## `ctx:polygon(points, fill?)`

## `ctx:char(num, charset?)`

## `ctx:text(txt, charset?)`

# License

MIT