# mtscad

OpenSCAD inspired minetest mod

Status: **WIP**

# Example

Files placed in `<worlddir>/mtscad/`

rot_test.lua
```lua
return function(ctx)
    ctx
    :with("wool:red")
    :cube(10,1,1)
    :with("wool:blue")
    :rotate(0,90,0)
    :cube(10,1,1)
    :with("wool:green")
    :rotate(0,90,0)
    :cube(10,1,1)
    :with("wool:yellow")
    :rotate(0,90,0)
    :cube(10,1,1)
    :translate(10,0,0)
    :with("moreblocks:slope_stone")
    :slope(1,1,0)
    :set_node()
end
```

test.lua
```lua
local rot_test = load("rot_test")

return function(ctx)
    ctx
    :with("default:stone")
    :cube(10, 1, 1)
    :cube(1, 10, 1)
    :cube(1, 1, 10)

    ctx
    :translate(10, 10, 10)
    :execute(rot_test)
end
```

```
/scad test
```