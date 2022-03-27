# mtscad

OpenSCAD inspired minetest mod

Status: **WIP**

# Example

Files placed in `<worlddir>/mtscad/`

rot_test.lua
```lua
return function(ctx)
    ctx
    :with({ name="wool:red" })
    :cube(10,1,1)
    :with({ name="wool:blue" })
    :rotate(0,90,0)
    :cube(10,1,1)
    :with({ name="wool:green" })
    :rotate(0,90,0)
    :cube(10,1,1)
    :with({ name="wool:yellow" })
    :rotate(0,90,0)
    :cube(10,1,1)
    :translate(10,0,0)
    :with({ name="moreblocks:slope_stone" })
    :slope({ x=1, y=1, z=0 })
    :set_node()
end
```

test.lua
```lua
local rot_test = load("rot_test")

return function(ctx)
    ctx
    :with({ name="default:stone" })
    :cube(10, 1, 1)
    :cube(1, 10, 1)
    :cube(1, 1, 10)

    ctx
    :translate(10, 10, 10)
    :execute(rot_test)

    ctx
    :with({ name="default:copperblock" })
    :translate(2,2,2)
    :grid(5, 5, 5)
end
```

```
/scad test
```